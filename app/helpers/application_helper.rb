module ApplicationHelper
  def validation_error(message)
    if message.class.to_s == "Array"
      message = message.join(", ")
    end
    return !message.to_s.blank? ? ("<div class='form_error' style='color :red;'>"+message.to_s+"</div>").html_safe : ""
  end

  def count
    Bid.joins("left join projects on bids.project_id = projects.id").where("projects.payment = '0'").count
  end

  def resource_name
    :user
  end

  def reputation
    @reputation = current_user.post_work + current_user.subscription + current_user.recommendations
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  
  def rating_ballot
    if @rating = current_user.ratings.find_by_bid_id(params[:id])
      @rating
    else
      current_user.ratings.new
    end
  end
  
  def current_user_rating
    if @rating = current_user.ratings.find_by_bid_id(params[:id])
      @rating.value
    else
      'N/A'
    end
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
  end
end
