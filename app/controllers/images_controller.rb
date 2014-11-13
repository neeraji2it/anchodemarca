class ImagesController < ApplicationController
  before_filter :is_login?

  def create
    @project = Project.find(params[:project_id])
    params[:image_images].to_a.each do |image_image|
      @project.images.build(:image => image_image)
    end
    if @project.save
      flash[:notice] = "Images has been uploaded successfully"
    else
      flash[:error] = 'Images upload failed. Please upload again'
    end
    redirect_to edit_project_path(@project)
  end

  def destroy
    @image = Image.find(params[:id])
    render :update do |page|
      if  @image.destroy
        page << "$('#project_image_#{params[:id]}').html('');"
        page.alert("successfully deleted")
      end
    end
  end
end
