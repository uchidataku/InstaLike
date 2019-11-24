class FavoritesController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]
  
  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    redirect_back(fallback_location: root_url)
  end
  
  def destroy
    @post = Post.find(params[:post_id])
    current_user.unlike(@post)
    redirect_back(fallback_location: root_url)
  end
end
