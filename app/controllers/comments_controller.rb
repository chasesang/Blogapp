class CommentsController < ApplicationController
  def create
  @post = Post.find(params[:post_id])
  # puts params
  comment_params = params.require(:comment).permit(:body)
  # puts review_params

      @comment = Comment.new(comment_params)
      @comment.post = @post


  # @answer = @queston.answers.build(answer_params)

  if @comment.save
  redirect_to post_path(@post), notice: 'Comments Created!'
  else

    render '/posts/show'

  end

end

def destroy
  comment = Comment.find(params[:id])
  comment.destroy
  redirect_to post_path(comment.post), notice: 'Review deleted!'
end

end
