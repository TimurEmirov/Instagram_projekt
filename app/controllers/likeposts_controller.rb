class LikepostsController < ApplicationController

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @post = Post.find(params[:post_id])
      @post.likeposts.create(user_id: current_user.id)
    end
    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
  if !(already_liked?)
    flash[:notice] = "Cannot unlike"
  else
    @post = Post.find(params[:post_id])
    @like = @post.likeposts.find(params[:id])
    @like.destroy
  end
  respond_to do |format|
    format.html { redirect_to @post }
    format.js
  end
end

  private

    def already_liked?
      Likepost.where(user_id: current_user.id, post_id:
      params[:post_id]).exists?
    end
end
