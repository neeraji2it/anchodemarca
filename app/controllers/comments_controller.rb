class CommentsController < ApplicationController
  before_filter :is_login?

  def new
    @bid = Bid.find(params[:bid_id])
    @comment = Comment.new
    render :layout => false
  end

  def create
    @bid = Bid.find(params[:bid_id])
    @comment = @bid.comments.new(params[:comment].merge(:user_id => current_user.id))
    if @comment.save
      render :update do |page|
        flash[:notice] = "Successfully commented this bid"
        page.reload
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    @bid = Bid.find(params[:bid_id])
    respond_to do |format|
      format.js
    end
  end
end
