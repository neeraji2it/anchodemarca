class Visitor < ActiveRecord::Base
  belongs_to :user
  belongs_to :bid
end