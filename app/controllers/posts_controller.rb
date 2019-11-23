class PostsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :new, :show, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def create
    @post = current_user.posts.build(posts_params)
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to root_path
    else
      flash[:danger] = "投稿に失敗しました"
      render 'top_pages#home'
    end
  end
  
  def new
    @post = current_user.posts.build
  end
  
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to root_path
  end
  
  private
   def posts_params
     params.require(:post).permit(:picture, :content)
   end
   
   def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_path if @post.nil?
   end
end
