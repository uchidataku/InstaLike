class CommentsController < ApplicationController
  before_action :user_signed_in?, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]
  
  def create
    @comment = Comment.create(text: comment_params[:text],
                            post_id: comment_params[:post_id], 
                            user_id: current_user.id)
    if @comment.save
      flash[:success] = "投稿にコメントしました"
      redirect_to root_path
    else
      render current_user
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to root_path
  end
  
  private
    def comment_params
      params.permit(:text, :post_id)
    end
    
    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_path if @comment.nil?
    end
end
