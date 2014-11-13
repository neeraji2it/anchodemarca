class ProjectsController < ApplicationController
  before_filter :is_login?, :only => ["new", "show", "edit","client_projects","tutor_projects"]
  before_filter :is_client?, :only => ["new", "edit"]

  def index
    redirect_to clients_clients_path
  end

  def show
    @project = Project.find(params[:id])
    @bids = @project.bids.order("created_at DESC").paginate(:page => params[:bid_links], :per_page => 8)
    @comments = @project.comments.order("created_at DESC").paginate(:page => params[:comment_page], :per_page => 5)
    @comment = Comment.new
  end

  def client_projects
    @project = Project.find(params[:id])
    @bids = @project.bids.order("created_at DESC").paginate(:page => params[:bid_links], :per_page => 8)
    @comments = @project.comments.order("created_at DESC").paginate(:page => params[:comment_page], :per_page => 5)
  end


  def new
    @user = current_user
    @project = Project.new
  end

  def get_project
    @category = Category.find(params[:id])
    categories = []
    c = @category
    while(c.present?) do
      categories << c
      c = Category.find_by_id(c.parent_id)
    end
    @project = Project.new(:category_id =>  @category.id, :categories => @category.category)
    1.times { @project.images.build }
    render :partial => 'get_project', :layout => false
  end

  def create
    @user = current_user
    @project = Project.new(params[:project])
    if @project.images.blank?
      1.times { @project.images.build }
    end
    if @project.save
      @user.update_attributes({
          :post_work => @user.post_work+5 ,
          :total => @user.total.to_i+5
        })
      flash[:notice] = "Project is Created Successfully"
      redirect_to clients_clients_path
    else
      flash[:error] = "Project Creation is Failed"
      render :action => 'new'
    end
  end


  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.images.blank?
      1.times { @project.images.build }
    end
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project Updated Sucessfully"
      redirect_to client_path(current_user)
    else
      flash[:error] = "Project Updation Failed"
      render :action => 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    redirect_to '/'
  end

end
