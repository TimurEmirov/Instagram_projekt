class CommentsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params.merge(user_id: current_user.id))
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to @post
    else
      flash[:danger] = "Comment not created!"
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'home/index'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id === current_user.id
      @comment.destroy
      flash[:success] = "Post deleted"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "No"
      redirect_to request.referrer || root_url
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
