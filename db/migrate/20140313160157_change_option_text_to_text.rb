class ChangeOptionTextToText < ActiveRecord::Migration
  def up
   change_column :options, :text, :text
   change_column :option_translations, :text, :text
  end

  def down
   change_column :options, :text, :string
   change_column :option_translations, :text, :string
  end
end
