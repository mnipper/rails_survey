class ResponseImage < ActiveRecord::Base
  attr_accessible :picture, :response_uuid, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at, :picture_data 
  has_attached_file :picture, :styles => { :small => ["150x150>", :medium => "300x300>"] } 
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  
  def picture_data=(data_value)
    StringIO.open(Base64.decode64(data_value)) do |data|
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "temp#{DateTime.now.to_i}.jpeg"
      data.content_type = "image/jpeg" 
      self.picture = data
    end
  end

end
