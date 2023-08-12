class PostsController < ApplicationController

  # before_action :set_post, [:show, :update, :edit, :destroy]
 
def index
   @posts = Post.all
 end

#  def show
#  end
 
 
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "post successfully created"
      redirect_to @post
    else
      flash[:error] = "Something went wrong"
      render 'new', status: :unprocessable_entity
    end
  end
  
#   def update
#       if @post.update(post_params)
#         flash[:success] = "post was successfully updated"
#         redirect_to @post
#       else
#         flash[:error] = "Something went wrong"
#         render 'edit'
#       end
#   end

# def destroy
#   if @post.destroy
#     flash[:success] = 'post was successfully deleted.'
#     redirect_to posts_url
#   else
#     flash[:error] = 'Something went wrong'
#     redirect_to posts_url
#   end
# end

# private

# def set_post
#   @post = Post.find(params[:id])
# end

def post_params
  params.require(:post).permit(:title, :description)
end

end
