class City < ActiveRecord::Base
  has_one :user
  belongs_to :country
end
