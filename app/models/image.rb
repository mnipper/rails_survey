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
#  description        :string(255)
#  number             :integer
#

class Image < ActiveRecord::Base
  attr_accessible :photo, :photo_file_name, :photo_content_type, :photo_file_size, :photo_updated_at, :question_id, :description, :number
  has_attached_file :photo, :styles => { :small => "200x200>", :medium => "300x300>" },
  :url  => "/:attachment/:id/:basename.:extension", :path => "files/:attachment/:id/:style/:basename.:extension" 
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :photo, :matches => [/png\Z/, /jpe?g\Z/]
  validates_with AttachmentSizeValidator, :attributes => :photo, :less_than => 1.megabytes

  def as_json(options={})
    super((options || {}).merge({
        methods: [:photo_url]
    }))
  end  
  
  def photo_url
    photo.url(:medium)
  end    
     
end
