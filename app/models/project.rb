class Project < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :images, :as => :imageable
  has_many :visitors,:dependent => :destroy
  has_many :comments, :as => :commentable
  has_many :project_recommenders, :dependent => :destroy
  has_many :bids, :dependent => :destroy
  has_many :participates, :dependent => :destroy

  validates :topic,:description,:community,:presence => {message: "no puede estar en blanco"}
  validates_numericality_of :payment, :presence => true, :only_integer => true

  validates :start_date,
    :date => { :after => (Date.today), :message => "debe ser mayor que el de hoy" }

  validate :start_must_be_before_end_time

  def start_must_be_before_end_time
    valid = start_date && end_date && start_date < end_date
    errors.add(:end_date, "La fecha final debe ser una fecha posterior a la fecha de inicio") unless valid
  end

  accepts_nested_attributes_for  :images,  :allow_destroy  => true,:reject_if => :all_blank

end
