class TagsController < ApplicationController
  def index
    @tags = Tag.all

    render json: @tags
  end

  def create
    @tag = Tag.create(text: params[:text])
    
    if @tag.save
      render json: @tag
    end
  end
end
