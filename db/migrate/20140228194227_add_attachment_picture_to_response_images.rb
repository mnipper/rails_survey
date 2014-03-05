class AddAttachmentPictureToResponseImages < ActiveRecord::Migration
  def self.up
    change_table :response_images do |t|
      t.attachment :picture
    end
  end

  def self.down
    drop_attached_file :response_images, :picture
  end
end
