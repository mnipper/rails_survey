class ChangeOptionTextToText < ActiveRecord::Migration
  def up
   change_column :options, :text, :text, limit: nil
   change_column :option_translations, :text, :text, limit: nil
  end

  def down
   change_column :options, :text, :string
   change_column :option_translations, :text, :string
  end
end
