class TutorsController < ApplicationController
  before_filter :is_login?, :except => ["index","views"]

  def index
    @courses = Course.paginate :page => params[:tutor_page], :order=>'updated_at desc', :per_page => 3
  end

  def tutors
    @courses = Course.where("user_id = #{current_user.id}").paginate :page => params[:tutor_page], :order=>'updated_at desc', :per_page => 6
  end

  def show
    @user = User.find(params[:id])
    @courses = Course.where("user_id = '#{@user.id}'").paginate :page => params[:client_page], :order=>'updated_at desc', :per_page => 6
  end

  def edit
    @user = User.find(params[:id])
    @countries = Country.all
  end

  def update_tutor
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully Updated your Profile"
      redirect_to tutors_tutors_path
    else
      @countries = Country.all
      flash[:error] = "Profile Updation Failed"
      render :action => 'edit'
    end
  end

  def views
    @users = User.where("users.surname = '#{params[:categories]}' and users.role = 'tutor'")
    render :partial => 'views', :layout => false
  end

end
