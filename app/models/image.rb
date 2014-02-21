class Image < ActiveRecord::Base
  has_attached_file :photo, :styles => { :small => ["200x150>", :png, :jpg, :jpeg] } 
                            
end
