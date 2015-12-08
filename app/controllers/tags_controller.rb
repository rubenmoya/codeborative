class TagsController < ApplicationController
  def index
    @tags = Tag.all

    render json: @tags
  end

  def create
    @tags = Tag.create(text: params[:text])

    render json: @tags
  end
end
