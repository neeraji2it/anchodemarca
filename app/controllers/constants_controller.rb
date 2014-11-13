class ConstantsController < ApplicationController
  before_filter :is_login?, :except => ["project_views","company","budget","social_categories","categories","course_categories","course_date","project_date","client_logos"]

  def visitor_count
    @bid = Bid.find(params[:id])
    @user = current_user
    if @visitor = Visitor.create(:user_id => current_user.id, :project_id => @bid.project_id, :view => 'View')
      @bid.update_attribute(:bid_count, @bid.bid_count+1)
      redirect_to project_bid_path(@bid.project_id,@bid)
    end
  end

  def bid_status
    @bid = Bid.find(params[:id])
    @user = current_user
    params[:status] == 'winner' ? (@bid.update_attribute(:status, 'winner')) : (params[:status] == 'second' ? (@bid.update_attribute(:status, 'second place')) : (@bid.update_attribute(:status, 'third place')))
    Winner.winner_proposal(@bid).deliver
    Winner.winner_project(@bid).deliver
    @user.update_attribute(:total, @user.total.to_i+10)
    @bid.user.update_attribute(:total, @bid.user.total.to_i+10)
    render :update do |page|
      flash[:notice] = "You are selected this proposal as #{@bid.status} of this project"
      page.reload
    end
  end

  def user_view
    @user = User.find(params[:id])
    @user_view = UserView.new(:user_id => @user.id, :viewer_id => current_user.id)
    if @user_view.save
      flash[:notice] = "Succefully viewed this profile"
      @user.role == 'client' ? (redirect_to client_path(@user)) : (@user.role == 'creative' ? (redirect_to creative_path(@user)) : (@user.role == 'tutor' ? (redirect_to tutor_path(@user)) : (redirect_to visitor_path(@user))))
    end
  end

  def recommender
    @user = User.find(params[:id])
    @recommender = Recommender.new(:user_id => @user.id,:recommender_id => current_user.id)
    if @recommender.user_id != current_user.id
      if @recommender.save
        current_user.update_attributes({
            :recommendations => current_user.recommendations.to_i+3,
            :total => current_user.total.to_i+3
          })
        @user.update_attributes({
            :recommendations => @user.recommendations.to_i+3,
            :total => @user.total.to_i+3
          })
        render :update do |page|
          flash[:notice] = "Suuccessfully Recommended for this user."
          page.reload
        end
      end
    else
      render :update do |page|
        flash[:error] = 'You are not recommended yourself'
        page.reload
      end
    end
  end

  def like
    @user = User.find(params[:id])
    @like = Like.new(:user_id => @user.id, :liker_id => current_user.id)
    if @like.user_id != current_user.id
      if @like.save
        render :update do |page|
          flash[:notice] = "Suuccessfully Liked for this user profile."
          page.reload
        end
      end
    else
      render :update do |page|
        flash[:error] = 'You are not Liked yourself'
        page.reload
      end
    end
  end

  def project_recommender
    @project = Project.find(params[:id])
    @project_recommender = ProjectRecommender.new(:user_id => current_user.id, :project_id => @project.id)
    if !current_user.project_recommend(@project)
      if @project_recommender.save
        render :update do |page|
          flash[:notice] = "Successfully recommended this Project."
          page.reload
        end
      end
    else
      render :update do |page|
        flash[:error] = "Already Recommended this project."
        page.reload
      end
    end
  end

  def like_proposal
    @bid = Bid.find(params[:id])
    @project_like = ProjectLike.new(:user_id => current_user.id, :bid_id => @bid.id, :project_id => @bid.project_id)
    if !current_user.project_like(@bid)
      if @project_like.save
        render :update do |page|
          flash[:notice] = "Successfully Liked this Proposal."
          page.reload
        end
      end
    else
      render :update do |page|
        flash[:error] = "Already Liked this Proposal."
        page.reload
      end
    end
  end

  def course_recommender
    @course = Course.find(params[:id])
    @course_recommender = ProjectRecommender.new(:user_id => current_user.id, :course_id => @course.id)
    if !current_user.course_recommend(@course)
      if @course_recommender.save
        render :update do |page|
          flash[:notice] = "Successfully recommended this Course."
          page.reload
        end
      end
    else
      render :update do |page|
        flash[:error] = "Already Recommended this course."
        page.reload
      end
    end
  end

  def project_views
    if params[:categories] == 'all'
      @projects = Project.paginate :page => params[:page], :per_page => 6
    else
      @projects = Project.paginate :page => params[:page], :per_page => 6
    end
    render :partial => 'project_views', :layout => false
  end

  def budget
    if params[:categories] == '100'
      @projects = Project.where('payment < 100 and payment != 0').order('payment desc')
    elsif params[:categories] == '500'
      @projects = Project.where('payment < 500 and payment > 100')
    elsif params[:categories] == 'all'
      @projects = Project.where("payment != 0").order('payment desc')
    end
    render :partial => 'budget', :layout => false
  end

  def course_date
    if params[:categories] == 'available'
      @courses = Course.where("from_date < '#{Date.today}' and to_date > '#{Date.today}'")
    elsif params[:categories] == 'expired'
      @courses = Course.where("to_date < '#{Date.today}'")
    elsif params[:categories] == 'next month'
      @courses = Course.where("from_date > '#{Date.today}' and to_date > '#{Date.today}'")
    end
    render :partial => 'course_date', :layout => false
  end

  def project_date
    if params[:categories] == 'available'
      @projects = Project.where("start_date < '#{Date.today}' and end_date > '#{Date.today}'")
    elsif params[:categories] == 'expired'
      @projects = Project.where("end_date < '#{Date.today}'")
    elsif params[:categories] == 'next month'
      @projects = Project.where("start_date > '#{Date.today}' and end_date > '#{Date.today}'")
    end
    render :partial => 'project_date', :layout => false
  end

  def categories
    conditions = !params[:categories].to_s.blank? ? "categories = '#{params[:categories]}'" : ""
    @projects = Project.find(:all, :conditions => [conditions])
    render :partial => 'categories', :layout => false
  end

  def company
    conditions = !params[:company_name].to_s.blank? ? "company_name = '#{params[:company_name]}'" : ""
    @users = User.find(:all, :conditions => [conditions])
    render :partial => 'company', :layout => false
  end

  def social_categories
    conditions = !params[:categories].to_s.blank? ? "categories = '#{params[:categories]}'" : ""
    @projects = Project.where("payment = '0' and #{conditions}")
    render :partial => 'social_categories', :layout => false
  end

  def course_categories
    conditions = !params[:categories].to_s.blank? ? "categories = '#{params[:categories]}'" : ""
    @courses = Course.find(:all, :conditions => [conditions])
    render :partial => 'course_categories', :layout => false
  end

  def client_logos
    conditions = !params[:image_file_name].to_s.blank? ? "image_file_name = '#{params[:image_file_name]}'" : ""
    @photos = Image.find(:all, :conditions => [conditions])
    render :partial => 'client_logos', :layout => false
  end

  def participate_course
    @course = Course.find(params[:id])
    @course_participate = Participate.new(:user_id => current_user.id, :course_id => @course.id)
    if !current_user.course_participate(@course)
      if @course_participate.save
        current_user.update_attribute(:total, current_user.total.to_i+5)
        render :update do |page|
          flash[:notice] = "Successfully Participated for this Course."
          page.reload
        end
      end
    else
      render :update do |page|
        flash[:error] = "Already Participated for this Course."
        page.reload
      end
    end
  end
end
