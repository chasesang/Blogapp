class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
  def new
    @post = Post.new
  end

  def index
    @posts = Post.last(50)
  end

  def show
    @post = Post.find params[:id]
    @comment = Comment.new
  end

  def create
    post_params= params.require(:post).permit([:title, :body, :category_id])
    @post = Post.new post_params
    @post.user = current_user
    if @post.save
      flash[:notice] = 'Post created!'
      redirect_to posts_path(@post)
    else
      flash[:alert] = 'Please fix erros below'
      render :new
    end
  end

  def destroy
    post = Post.find params[:id]
    post.destroy
    redirect_to posts_path, notice: "Post deleted!"
  end

    def edit
    @post = Post.find params[:id]

    end

    def update
    @post = Post.find params[:id]
        post_params = params.require(:post).permit([:title, :body, :category_id])
    if @post.user != current_user
      flash[:alert] = "You cannot change a post that you did not create"
      redirect_to post_path(@post)
    elsif @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
    end
end
