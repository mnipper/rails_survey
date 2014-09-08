class AddDeletedAtToRulesTable < ActiveRecord::Migration
  def change
    add_column :rules, :deleted_at, :time
  end
end
