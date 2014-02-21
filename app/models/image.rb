class Image < ActiveRecord::Base
  has_attached_file :photo, :styles => {:small => "200x150>"}, 
                            :url => "/assets/images/:id/:style/:basename.:extension", 
                            :path => ":rails_root/public/assets/images/:id/:style/:basename.:extension"
                            
end
