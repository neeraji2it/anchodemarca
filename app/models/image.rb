class Image < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  has_attached_file :image, :styles => {:thumb => "100*100", :large => "400*320", :small => "150*200"}
  validates_attachment_content_type :image,
    :content_type => [ 'image/jpeg','image/jpg', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg' ]
  validates_attachment_presence :image
  validates_attachment_size(:image, :less_than => 10.megabytes)
end
