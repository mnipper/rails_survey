class AddAttachmentToAndroidUpdates < ActiveRecord::Migration
  def change
    add_attachment :android_updates, :apk_update
  end
end
