class ProjectCommentsController < ApplicationController
  before_filter :is_login?

  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.new(params[:comment].merge(:user_id => current_user.id))
    if @comment.save
      render :update do |page|
        flash[:notice] = "Successfully commented this project"
        page.reload
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    respond_to do |format|
      format.js
    end
  end
end
