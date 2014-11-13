class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  has_attached_file :image, :styles => {:thumb => "100*100", :large => "400*320", :small => "150*200"} if Rails.env == 'development'
  has_attached_file :image,:whiny => false,:storage => :s3,:s3_credentials => "#{Rails.root}/config/s3.yml",:bucket => "Anchodemarca",:path => "uploaded_files/profile/:id/:style/:basename.:extension",:styles => {:original => "900*900>", :default => "280*190>",:other => '96*96>'} if Rails.env == 'production'
  validates_attachment_content_type :image,
    :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]
  validates_attachment_presence :image
  validates_attachment_size(:image, :less_than => 10.megabytes)
end
