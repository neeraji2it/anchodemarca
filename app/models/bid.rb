class Bid < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  has_many :images, :as => :imageable
  has_many :comments, :as => :commentable
  has_many :project_likes, :dependent => :destroy
  has_many :ratings
  has_many :raters, :through => :ratings, :source => :users
  validates :comment, :presence => true
  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => :all_blank
  
  
  def average_rating
    @value = 0
    self.ratings.each do |rating|
      @value = @value + rating.value
    end
    @total = self.ratings.size
    @value.to_f / @total.to_f
  end
end
