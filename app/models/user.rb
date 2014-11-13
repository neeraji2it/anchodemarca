require 'digest/sha2'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable,:token_authenticatable
  belongs_to :country
  belongs_to :city
  has_many :creative_folios, :dependent => :destroy
  has_many :user_views, :dependent => :destroy
  has_many :categories,:dependent => :destroy
  has_many :projects,:dependent => :destroy
  has_many :visitors,:dependent => :destroy
  has_many :project_likes, :dependent => :destroy
  has_many :comments,:dependent => :destroy
  has_many :received_recommenders, :class_name => "Recommender", :foreign_key => :recommender_id, :dependent => :destroy, :order => "created_at DESC"
  has_many :sent_recommenders, :class_name => "Recommender", :foreign_key => :user_id, :dependent => :destroy, :order => "created_at DESC"
  has_many :received_likes, :class_name => "Like", :foreign_key => :liker_id, :dependent => :destroy, :order => "created_at DESC"
  has_many :sent_likes, :class_name => "Like", :foreign_key => :user_id, :dependent => :destroy, :order => "created_at DESC"
  has_many :received_comments, :class_name => "UserComment", :foreign_key => :commenter_id, :dependent => :destroy, :order => "created_at DESC"
  has_many :sent_comments, :class_name => "UserComment", :foreign_key => :user_id, :dependent => :destroy, :order => "created_at DESC"
  has_many :courses, :dependent => :destroy
  has_many :participates, :dependent => :destroy
  has_many :project_recommenders, :dependent => :destroy
  has_many :bids, :dependent => :destroy
  has_many :ratings
  has_many :rated_bids, :through => :ratings, :source => :bids
  # Setup accessible (or protected) attributes for your model
  attr_accessible :name,:user_name,:post_work,:total,:subscription,:post_class,:recommenations, :surname,:email, :password, :password_confirmation, :remember_me, :date_of_birth, :document_type,:document_num,:country_id,:city_id,:avatar,:company_name,:position,:text_accept,:i_accept,:receive_news,:retrived_title,:currently_studying,:occupation,:current_occupation,:creative_am,:participate_in_trining,:formal_duites,:invite_private_calls,:outstanding_releave,:skills,:laboral_disposition,:schedule,:sex,:phone
  validates_format_of :email, :with=>email_regexp, :allow_blank => true, :message=>"new error message here" 
  validates :name, :surname,:document_type,:user_name,:country_id,:city_id,:text_accept,:date_of_birth,:sex, :presence => true
  validates :phone, :length => {:minimum => 10, :maximum => 15}, :format => { :with => /\A\S[0-9\+\/\(\)\s\-]*\z/i }, :allow_nil  => true
  validates_numericality_of :document_num, :presence => true, :only_integer => true
  validates_acceptance_of :i_accept
  validates_acceptance_of :receive_news
  validates_acceptance_of :formal_duites, :presence => { :if => :creative_am_required? }
  validates_acceptance_of :laboral_disposition, :presence => { :if => :schedule_required? }
  validates :retrived_title,:currently_studying, :occupation,:creative_am,:participate_in_trining,:invite_private_calls,:outstanding_releave, :presence => { :if => :retrived_title_required? }
  validates :skills, :presence => { :if => :layout_work_required? }
  validates :company_name,:position, :presence => { :if => :company_name_required? }
  validates :schedule, :presence => { :if => :schedule_required? }
  after_create :subscriber

  has_attached_file :avatar, :styles => {:medium => "300x300>", :thumb => "100x100>"}, :default_url => "/images/photo_icon.jpg"

  def subscriber
    Winner.create_subscriber(self).deliver
  end

  #  define_index do
  #    indexes name
  #    indexes surname
  #    indexes role
  #  end


  def retrived_title_required?
    !self.role.nil? and ['creative','tutor'].include?(self.role)
  end
  
  def layout_work_required?
    !self.role.nil? and ['creative'].include?(self.role)
  end

  def company_name_required?
    !self.role.nil? and ['client'].include?(self.role)
  end

  def schedule_required?
    !self.role.nil? and ['tutor'].include?(self.role)
  end

  def course_recommend(course)
    self.project_recommenders.find_by_course_id(course.id)
  end

  def project_recommend(project)
    self.project_recommenders.find_by_project_id(project.id)
  end

  def project_like(bid)
    self.project_likes.find_by_bid_id(bid.id)
  end
  
  def bid(bid)
    self.bids.find_by_id(bid.id)
  end

  def course_participate(course)
    self.participates.find_by_course_id(course.id)
  end
end
