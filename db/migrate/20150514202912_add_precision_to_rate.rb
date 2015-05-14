class AddPrecisionToRate < ActiveRecord::Migration
  def change
    change_column :surveys, :completion_rate, :decimal, :precision => 3, :scale => 2
  end
end
