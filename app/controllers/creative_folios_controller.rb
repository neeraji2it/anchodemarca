class CreativeFoliosController < ApplicationController

  def new
    @folio = CreativeFolio.new
  end

  def create
    @folio = CreativeFolio.new(params[:creative_folio])
    @folio.user_id = current_user.id
    if @folio.save
      flash[:notice] = "Successfully Uploaded porta folio."
      redirect_to creatives_creatives_path
    else
      flash[:error] = "Failed to upload."
      render :action => 'new'
    end
  end

  def edit
    @folio = CreativeFolio.find(params[:id])
  end

  def update
    @folio = CreativeFolio.find(params[:id])
    if @folio.update_attributes(params[:creative_folio])
      flash[:notice] = "Successfully Updated porta folio."
      redirect_to creatives_creatives_path
    else
      flash[:error] = "Failed to upload."
      render :action => 'edit'
    end
  end
end
