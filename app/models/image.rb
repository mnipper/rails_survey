class Image < ActiveRecord::Base
  attr_accessible :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at, :question_id
  has_attached_file :photo, :styles => { :small => ["200x200>", :medium => "300x300>"] } 
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
    
  def as_json
    { 
      id: self.id, question_id: self.question_id, file_name: self.photo_file_name, content_type: self.photo_content_type, 
      file_size: self.photo_file_size, image_url: self.photo.url, created_at: self.created_at, updated_at: self.updated_at 
    }
  end           
end
