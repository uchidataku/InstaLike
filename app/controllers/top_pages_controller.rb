class TopPagesController < ApplicationController
  def home
    if user_signed_in?
      @user = current_user
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
  def help
  end
  
  def contact
  end
  
end
