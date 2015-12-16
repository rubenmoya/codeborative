class TagsController < ApplicationController
  def index
    @tags = Tag.all

    render json: @tags
  end

  def create
    @tag = Tag.create(text: params[:text])

    render json: @tag
  end
end
