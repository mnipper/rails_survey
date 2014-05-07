# == Schema Information
#
# Table name :response_images
#
# id                      :integer      not null, primary key
# response_uuid           :string       not null
# created_at              :datetime 
# updated_at              :datetime    
# picture_file_name       :string(255)    
# picture_content_type    :string(255)    
# picture_file_size       :integer    
# picture_updated_at      :datetime 

class ResponseImage < ActiveRecord::Base
  attr_accessible :picture, :response_uuid, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at, :picture_data 
  has_attached_file :picture, :styles => { :small => ["150x150>", :medium => "300x300>"] } 
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  belongs_to :response, :foreign_key => :response_uuid, :primary_key => :uuid
  delegate :project, to: :response 
  validates :response_uuid, presence: true
  
  def picture_data=(data_value)
    StringIO.open(Base64.decode64(data_value)) do |data|
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "temp#{DateTime.now.to_i}.jpeg"
      data.content_type = "image/jpeg" 
      self.picture = data
    end
  end

  def as_json(options={})
    super((options || {}).merge({
        methods: [:picture_url]
    }))
  end  
  
  def picture_url
    picture.url(:small)
  end

end
