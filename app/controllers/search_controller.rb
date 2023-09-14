class SearchController < ApplicationController
  def index
    @query = Post.includes(:user, :rich_text_description, :category).ransack(params[:q])
    @posts = @query.result(distinct: true)
  end
end
