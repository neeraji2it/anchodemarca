class CoursesController < ApplicationController
  before_filter :is_login?

  def new
    @course = Course.new
    1.times { @course.images.build  }
  end

  def get_course
    @category = Category.find(params[:id])
    categories = []
    c = @category
    while(c.present?) do
      categories << c
      c = Category.find_by_id(c.parent_id)
    end
    @course = Course.new(:category_id =>  @category.id, :categories => @category.category)
    1.times { @course.images.build }
    render :partial => 'get_course', :layout => false
  end


  def create
    @user = current_user
    @course = Course.new(params[:course])
    if @course.save
      @user.update_attributes({
          :post_class => @user.post_class+5,
          :total => @user.total.to_i+5
        })
      flash[:notice] = "Successfully Create the Course"
      redirect_to course_path(@course)
    else
      if @course.images.blank?
        1.times { @course.images.build  }
      end
      flash[:error] = "Course Creation Failed"
      render :action => 'new'
    end
  end

  def show
    @user = current_user
    @course = Course.find(params[:id])
    @comments = @course.comments.paginate :page => params[:comment_page], :per_page => 5
    @comment = Comment.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.images.blank?
      1.times { @course.images.build }
    end
    if @course.update_attributes(params[:course])
      flash[:notice] = "Project Updated Sucessfully"
      redirect_to course_path(@course)
    else
      flash[:error] = "Project Updation Failed"
      render :action => 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    if @course.destroy
      flash[:notice] = "Successfully Deleted the Course"
      redirect_to tutors_tutors_path
    end
  end
end
