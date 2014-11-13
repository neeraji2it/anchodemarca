class SearchesController < ApplicationController
  before_filter :is_login?

  def search
    @users = User.where("(name = '#{params[:query]}' or role = '#{params[:query]}') and id != '#{current_user.id}'")
  end
end
