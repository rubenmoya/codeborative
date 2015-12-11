class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: [:show, :update]

  def show
  end


  def create
    if Document.between(params[:user_id], params[:friend_id]).present?
      @document = Document.between(params[:user_id], params[:friend_id]).first
      redirect_to document_path(@document)
    else
      @document = Document.create!(document_params)
      redirect_to document_path(@document)
    end
  end

  def update
    if @document.update(text: params[:text])
      ActionCable.server.broadcast "document:#{@document.id}", @document
    end
  end

  private

  def set_document
    @document = Document.find_by_id(params[:id])
  end

  def document_params
    params.permit(:user_id, :friend_id)
  end
end
