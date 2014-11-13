class Category < ActiveRecord::Base
  belongs_to :user
  has_many :projects,:dependent => :destroy
  has_many :courses,:dependent => :destroy
end
