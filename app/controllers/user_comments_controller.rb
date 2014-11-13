class UserCommentsController < ApplicationController
  before_filter :is_login?

  def new
    @user = User.find(params[:user_id])
    @user_comment = @user.sent_comments.new
    render :layout => false
  end

  def create
    @user = User.find(params[:user_id])
    @user_comment = @user.sent_comments.new(params[:user_comment])
    @user_comment.user_id = current_user.id
    @user_comment.commenter_id = @user.id
    if @user_comment.commenter_id != current_user.id
      if @user_comment.save
        render :update do |page|
          flash[:notice] = "Successfully Commented for his profile"
          page.reload
        end
      else
        respond_to do |format|
          format.js
        end
      end
    else
      render :update do |page|
        flash[:error] = "You are not Commented Yourself."
        page.reload
      end
    end
  end

  def user_comments
    @user = current_user
    @user_comments = @user.received_comments.all
    render :layout => false
  end
end
