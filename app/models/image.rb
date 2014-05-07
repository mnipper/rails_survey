# == Schema Information
#
# Table name: images
#
#  id                 :integer          not null, primary key
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  question_id        :integer
#

class Image < ActiveRecord::Base
  attr_accessible :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at, :question_id
  has_attached_file :photo, :styles => { :small => ["200x200>", :medium => "300x300>"] } 
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/

  
  def as_json(options={})
    super((options || {}).merge({
        methods: [:photo_url]
    }))
  end  
  
  def photo_url
    photo.url(:small)
  end    
     
end
