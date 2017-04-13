class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
  def new
    @post = Post.new
  end

  def index
    @posts = Post.last(6)
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
    @post = Post.find params[:id]
    if can? :destory, @post
      @post.destroy
    redirect_to posts_path, notice: "Post deleted!"
    else
      redirect_to post_path(@post), alert: "access defined"
    end
  end

    def edit
    @post = Post.find params[:id]
    redirect_to root_path, alert: "access defined" unless can? :edit, @post

    end

    def update

      @post = Post.find params[:id]
      post_params = params.require(:post).permit([:title, :body, :category_id])
      if can? :edit, @post
        @post.update(post_params)
        redirect_to post_path(@post), notice: 'Post updated!'
      else
        redirect_to post_path(@post), notice: 'access denied'
      end
    end

end
