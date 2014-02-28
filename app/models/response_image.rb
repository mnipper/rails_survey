class ResponseImage < ActiveRecord::Base
  has_attached_file :picture, :styles => { :small => ["150x150>", :medium => "300x300>"] } 
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  attr_accessible :picture, :response_uuid, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at

end
