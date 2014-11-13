class RatingsController < ApplicationController
  def create
    @bid = Bid.find(params[:bid_id])
    @rating = Rating.new(params[:rating].merge(:user_id => current_user.id, :bid_id => @bid.id))
    @rating.save
  end

  def update
    @bid = Bid.find(params[:bid_id])
    @rating = current_user.ratings.find_by_bid_id(@bid.id)
    @rating.update_attributes(params[:rating])
  end
end
