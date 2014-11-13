class Country < ActiveRecord::Base
  has_many :cities
  has_one :user
end
