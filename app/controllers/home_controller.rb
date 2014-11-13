class HomeController < ApplicationController
  def index
    @projects = Project.where("end_date > '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}'").order('created_at asc')
    @creatives = Bid.joins("left join projects on bids.project_id = projects.id").where("projects.end_date > '#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}'").order('created_at desc')
    @tutors = Course.where("to_date > '#{Time.now.strftime("%Y-%m-%d")}'").order('created_at asc')
  end

  def new
    render :layout => false
  end

  def about_us
    
  end

  def how_it_works

  end

  def benifits_of_am

  end

  def our_services
    
  end

  def search
    
  end

  def client_categories
    @photos = Image.where(["imageable_id IN (#{Bid.all.map{|b| b.id}.join(',')}) and imageable_type = 'Bid'"])
    render :partial => 'client_categories', :layout => false
  end

  def creative_categories
    render :partial => 'creative_categories', :layout => false
  end
  
  def tutor_categories
    render :partial => 'tutor_categories', :layout => false
  end
end
