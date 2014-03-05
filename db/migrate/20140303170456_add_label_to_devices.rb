class AddLabelToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :label, :string
  end
end
