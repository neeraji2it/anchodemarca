class VisitorsController < ApplicationController
  before_filter :is_login?, :only => ["show", "edit", "visitors","update_visitor"]

  def index
  end

  def visitors
    @projects = Project.where("end_date >= '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}'").paginate :page => params[:project_page], :order=>'updated_at desc', :per_page => 6
    @courses = Course.paginate :page => params[:course_page], :order=>'updated_at desc', :per_page => 6
  end

  def show
    @user = User.find(params[:id])
    @projects = Project.paginate :page => params[:project_page], :order=>'updated_at desc', :per_page => 6
    @courses = Course.paginate :page => params[:course_page], :order=>'updated_at desc', :per_page => 6
  end

  def edit
    @user = User.find(params[:id])
    @countries = Country.all
  end

  def update_visitor
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully Updated your Profile"
      redirect_to visitors_visitors_path
    else
      @countries = Country.all
      flash[:error] = "Profile Updation Failed"
      render :action => 'edit'
    end
  end
end
