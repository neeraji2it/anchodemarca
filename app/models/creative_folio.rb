class CreativeFolio < ActiveRecord::Base
  belongs_to :user
  validates :title,:technique, :presence => true
  has_attached_file :folio, :styles => {:thumb => "100*100", :small => "300*300", :large => "400*320"} if Rails.env == 'development'
  has_attached_file :folio, :whiny => false,:storage => :s3,:s3_credentials => "#{Rails.root}/config/s3.yml",:bucket => "Anchodemarca",:path => "uploaded_files/profile/:id/:style/:basename.:extension",:styles => {:original => "900*900>", :default => "280*190>", :other => "96*96>"} if Rails.env == "production"
  validates_attachment_content_type :folio, :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]
  validates_attachment_presence :folio
  validates_attachment_size(:folio, :lessthan => 10.megabytes)
end
