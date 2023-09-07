class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]
  before_action :set_post, only: %i[show edit update destroy]
 
def index
   @posts = Post.all.includes(:user).order(created_at: :desc)
 end

 def show
  @post.update(views: @post.views + 1)
  @comments = @post.comments.includes(:user).order(created_at: :desc)
  ahoy.track 'Viewed Post', post_id: @post.id
  mark_notifications_as_read
 end
 
 
  def new
    @post = Post.new
  end

  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  
 # PATCH/PUT /posts/1 or /posts/1.json
 def update
  respond_to do |format|
    if @post.update(post_params)
      format.html { redirect_to post_url(@post), notice: 'Post was successfully updated.' }
      format.json { render :show, status: :ok, location: @post }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @post.errors, status: :unprocessable_entity }
    end
  end
end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])

    # If an old id or a numeric id was used to find the record, then
    # the request slug will not match the current slug, and we should do
    # a 301 redirect to the new path
    # redirect_to @post, status: :ok
    redirect_to @post, status: :moved_permanently if params[:id] != @post.slug
  end

def post_params
  params.require(:post).permit(:title, :description, images: [])
end

def mark_notifications_as_read
  return unless current_user
    notifications_to_mark_as_read = @post.notifications_as_post.where(recipient: current_user)
    notifications_to_mark_as_read.update_all(read_at: Time.zone.now)
  
end

end
