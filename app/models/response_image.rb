# == Schema Information
#
# Table name: response_images
#
#  id                   :integer          not null, primary key
#  response_uuid        :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  picture_file_name    :string(255)
#  picture_content_type :string(255)
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#

class ResponseImage < ActiveRecord::Base
  attr_accessible :picture, :response_uuid, :picture_file_name, :picture_content_type, :picture_file_size, :picture_updated_at, :picture_data 
  has_attached_file :picture, :styles => { :small => "150x150>", :medium => "300x300>" }, 
    :url  => "/:attachment/:id/:basename.:extension", :path => "files/:attachment/:id/:style/:basename.:extension"  
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  belongs_to :response, :foreign_key => :response_uuid, :primary_key => :uuid
  delegate :project, to: :response 
  validates :response_uuid, presence: true
  
  def picture_data=(data_value)
    StringIO.open(Base64.decode64(data_value)) do |data|
      data.class.class_eval { attr_accessor :original_filename, :content_type }
      data.original_filename = "created_at_#{DateTime.now.to_i}.jpeg"
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
  
  def self.to_zip(name, zipped_file, pictures_export_id)
    zipped_file = File.open(zipped_file, "a+")
    Zip::OutputStream.open(zipped_file.path) do |zipfile|
      all.each do |response_image|
        title = response_image.versioned_question(response_image.response.question_identifier).question_identifier + '-' + response_image.response.id.to_s + '-' + response_image.picture_file_name
        zipfile.put_next_entry("#{name}/#{title}")
        photos_root = File.join('files').to_s
        photo_path = response_image.picture.url.split('?')
        photo_path = photo_path[0]
        path_arr = photo_path.split('/')
        path_arr.insert(3, 'original')
        photo_abs_url = photos_root + path_arr.join("/")
        photo_data = open(photo_abs_url)
        zipfile.print IO.read(photo_data)
      end
    end
    zipped_file.close
    pictures_export = ResponseImagesExport.find(pictures_export_id)
    pictures_export.update(:done => true)
  end
  
  def versioned_question(qid)
    @versioned_question ||= response.instrument_version.find_question_by(question_identifier: qid)
  end

end
