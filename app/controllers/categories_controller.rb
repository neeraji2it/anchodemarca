class CategoriesController < ApplicationController
  before_filter :is_admin?
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    @category.user_id = current_user.id
    if @category.save
      flash[:notice] = 'Category Successfully created'
      redirect_to '/'
    else
      flash[:error] = 'Category Creation Failed'
      render :action => "new"
    end
  end
end
