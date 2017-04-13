class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
  # puts params
    comment_params = params.require(:comment).permit(:body)
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: 'Comments Created!'
    else
      render '/posts/show'
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if can? :destroy, comment
      comment.destroy
      redirect_to post_path(comment.post), notice: 'Review deleted!'
    else
      redirect_to post_path(comment.post), notice: 'access denied'
    end
  end

end
