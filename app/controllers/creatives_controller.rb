class CreativesController < ApplicationController
  before_filter :is_login?, :except => ["index","views","likes"]

  def index
    @bids = CreativeFolio.where("title is not null").order('created_at desc').order("'created_at desc'").paginate :page => params[:creative_page], :per_page => 3
  end

  def creatives
    @folios = CreativeFolio.where("user_id = #{current_user.id}").paginate :page => params[:project_bids], :per_page => 6
    @projects = Project.where("end_date >= '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}'").paginate :page => params[:project_images], :order=>'updated_at desc', :per_page => 6
  end

  def show
    @user = User.find(params[:id])
    #    @bids = Project.where("projects.user_id = '#{current_user.id}' AND bids.project_id IS NOT NULL").joins("left join  users on projects.user_id = users.id left join bids on bids.project_id = projects.id ")
    @folios = CreativeFolio.where("user_id = #{@user.id}").paginate :page => params[:project_bids], :per_page => 6
    @projects = Project.where("end_date >= '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}'").paginate :page => params[:page], :order=>'updated_at desc', :per_page => 6
  end
  
  def edit
    @user = User.find(params[:id])
    @countries = Country.all
  end

  def update_creative
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully Updated your Profile"
      redirect_to creatives_creatives_path
    else
      @countries = Country.all
      flash[:error] = "Profile Updation Failed"
      render :action => 'edit'
    end
  end

  def views
    @users = User.where("users.surname = '#{params[:categories]}' and users.role = 'creative'")
    render :partial => 'views', :layout => false
  end

  def likes
    if params[:categories] == 'top'
      @bids = Bid.where('bid_count > 10').paginate :page => params[:page], :per_page => 10
    elsif params[:categories] == 'all'
      @bids = Bid.all
    end
    render :partial => 'likes', :layout => false
  end

end
