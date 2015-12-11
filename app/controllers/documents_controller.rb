class DocumentsController < ApplicationController
  before_action :authenticate_user!

  def create
    if Document.between(params[:user_id], params[:friend_id]).present?
      @document = Document.between(params[:user_id], params[:friend_id]).first
      redirect_to document_path(@document)
    else
      @document = Document.create!(document_params)
      redirect_to document_path(@document)
    end
  end

  private

  def document_params
    params.permit(:user_id, :friend_id)
  end
end
