class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      # user.Micropost.where("user_id = ?", user.id).paginate(page: params[:page])
      @feed_items = current_user.feed.paginate(page: params[:page])
    else
      @feed_items = []
      render 'static_pages/home' 
    end
  end

  def help
  end

  def about
  end

  def contact
  end
end
