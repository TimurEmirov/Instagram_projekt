class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @post = current_user.posts.build if authenticate_user!
  end

  def help
  end

end
