class ChangeResponseStringToResponseTextForResponses < ActiveRecord::Migration
  def up
    change_column :responses, :text, :text, limit: nil
  end

  def down
    change_column :responses, :text, :string
  end
end
