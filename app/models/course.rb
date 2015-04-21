class Course < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :comments, :as => :commentable
  has_many :images, :as => :imageable
  has_many :project_recommenders, :dependent => :destroy
  has_many :project_likes, :dependent => :destroy
  has_many :participates, :dependent => :destroy

  validates :title, :description,:course_type, :presence => {message: "no puede estar en blanco"}
  validates_numericality_of :course_hours, :presence => true, :only_integer => true
  validates :price, :format => { :with => /^\d+??(?:\.\d{0,2})?$/ }, :presence => { :if => :price_required?, message: "no puede estar en blanco"}
  

  validates :from_date,
    :date => { :after => (Date.today), :message => "debe ser mayor que el de hoy" }

  validate :form_date_must_be_before_to_date

  def price_required?
    !self.course_type.nil? and ['Paid'].include?(self.course_type)
  end

  def form_date_must_be_before_to_date
    valid = from_date && to_date && from_date < to_date
    errors.add(:to_date, "La fecha final debe ser una fecha posterior a la fecha de inicio") unless valid
  end

  accepts_nested_attributes_for :images, :allow_destroy => true, :reject_if => :all_blank
end
