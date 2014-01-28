class AddTimeTakenToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :time_started, :datetime
    add_column :responses, :time_ended, :datetime
  end
end
