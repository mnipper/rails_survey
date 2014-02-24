class Image < ActiveRecord::Base
  attr_accessible :name, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at, :question_id
  has_attached_file :photo, :styles => { :small => ["200x150>", :png, :jpg, :jpeg] } 
                            
end
