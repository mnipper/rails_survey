class AddSectionChangedToSectionTranslation < ActiveRecord::Migration
  def change
    add_column :section_translations, :section_changed, :boolean, :default => false
  end
end
