class UsersController < ApplicationController
  before_action :user_signed_in?, only: [:show, :index]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end
end
