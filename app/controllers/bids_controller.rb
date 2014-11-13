class BidsController < ApplicationController
  before_filter :is_login?

  def show
    @project = Project.find(params[:project_id])
    @bid = @project.bids.find(params[:id])
    @comments = @bid.comments.order("created_at DESC").paginate(:page => params[:comment_page], :per_page => 5)
    @comment = Comment.new
  end
  
  def new
    @project = Project.find(params[:project_id])
    @comments = @project.comments.order("created_at DESC").paginate(:page => params[:comment_page], :per_page => 5)
    @bid = @project.bids.new(:user => current_user)
    1.times { @bid.images.build  }
  end

  def create
    @project = Project.find(params[:project_id])
    @comments = @project.comments.order("created_at DESC").paginate(:page => params[:comment_page], :per_page => 5)
    @comment = Comment.new
    @bid = @project.bids.new(params[:bid])
    @user = current_user
    @bid.user_id = @user.id
    @bids = @project.bids.paginate(:page => params[:page], :per_page => 4)
    if @bid.images.blank?
      1.times { @bid.images.build  }
    end
    if @bid.save
      @user.update_attributes({
          :post_work => @user.post_work+1,
          :total => @user.total.to_i+1
        })
      render :update do |page|
        page.reload
      end
    else
      if remotipart_submitted?
        respond_to do |format|
          format.js
        end
      end
    end
  end
  
end
