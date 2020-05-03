class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    if authenticate_user!
      @post = current_user.posts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end


end
