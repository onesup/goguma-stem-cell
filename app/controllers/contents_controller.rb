class ContentsController < ApplicationController
  def index
    @contents = Content.all
    render json: @contents, each_serializer: ContentsSerializer
  end

  def show
    @content = Content.find(params[:id])
    render json: @content
  end
end
