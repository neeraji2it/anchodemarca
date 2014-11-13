class UsersController < ApplicationController


  def client
    @user = User.new
    @countries = Country.all
  end

  def create_client
    @user = User.new(params[:user])
    @user.role = 'client'
    if @user.save
      @user.update_attributes({
          :subscription => 5,
          :total => 5
        })
      flash[:notice] = "Usted recibira un correo electronico con instrucciones sobre como confirmar su cuenta en unos pocos minutos."
      redirect_to root_path
    else
      @countries = Country.all
      render :action => 'client'
    end
  end

  def creative
    @user = User.new
    @countries = Country.all
  end

  def create_creative
    @user = User.new(params[:user])
    @user.role = 'creative'
    if @user.save
      @user.update_attributes({
          :subscription => 5,
          :total => 5
        })
      flash[:notice] = "Usted recibira un correo electronico con instrucciones sobre como confirmar su cuenta en unos pocos minutos."
      redirect_to root_path
    else
      @countries = Country.all
      render :action => 'creative'
    end
  end

  def tutor
    @user = User.new
    @countries = Country.all
  end

  def create_tutor
    @user = User.new(params[:user])
    @user.role = 'tutor'
    if @user.save
      @user.update_attributes({
          :subscription => 5,
          :total => 5
        })
      flash[:notice] = "Usted recibira un correo electronico con instrucciones sobre como confirmar su cuenta en unos pocos minutos."
      redirect_to root_path
    else
      @countries = Country.all
      render :action => 'tutor'
    end
  end

  def visitor
    @user = User.new
    @countries = Country.all
  end

  def create_visitor
    @user = User.new(params[:user])
    @user.role = 'visitor'
    if @user.save
      @user.update_attributes({
          :subscription => 2,
          :total => 2
        })
      flash[:notice] = "Usted recibira un correo electronico con instrucciones sobre como confirmar su cuenta en unos pocos minutos."
      redirect_to root_path
    else
      @countries = Country.all
      render :action => 'visitor'
    end
  end

  def add_cities
    @country = Country.find(params[:country_id], :joins => :cities)
    respond_to do |format|
      format.js
    end
  end

  def creative_reputation
    if params[:categories] == 'all'
      @users = User.where("role = 'creative'")
    else
      @users = User.where("total > 10 and role = 'creative'")
    end
    render :partial => 'reputation', :layout => false
  end

  def tutor_reputation
    if params[:categories] == 'all'
      @users = User.where("role = 'tutor'")
    else
      @users = User.where("total > 10 and role = 'tutor'")
    end
    render :partial => 'reputation', :layout => false
  end

end

