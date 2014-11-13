class ClientsController < ApplicationController
  before_filter :is_login?, :except => ["index"]
  
  def index
    @projects = Project.where("end_date >= '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}'").paginate :page => params[:client_page], :order=>'updated_at desc', :per_page => 3
  end

  def clients
    @projects = Project.where("end_date >= '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}' and user_id = '#{current_user.id}'").paginate :page => params[:client_page], :order=>'updated_at desc', :per_page => 6
  end

  def show
    @user = User.find(params[:id])
    @projects = Project.where("user_id = '#{@user.id}'").paginate :page => params[:client_page], :order=>'updated_at desc', :per_page => 6
  end

  def edit
    @user = User.find(params[:id])
    @countries = Country.all
  end

  def update_client
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully Updated your Profile"
      redirect_to clients_clients_path
    else
      @countries = Country.all
      flash[:error] = "Profile Updation Failed"
      render :action => 'edit'
    end
  end

end
