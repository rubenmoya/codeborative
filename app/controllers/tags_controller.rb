class TagsController < ApplicationController
  def index
    @tags = Tag.all

    render json: @tags
  end

  def create
    @tag = Tag.create(text: params[:text])

    if @tag.save
      render status: :created, json: @tag
    else
      render nothing: true, status: :bad_request
    end
  end
end
