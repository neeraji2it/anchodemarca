class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  belongs_to :course
  belongs_to :bid
  validates :comment, :presence => true
end
