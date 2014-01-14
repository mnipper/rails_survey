class AddSpecialResponseToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :special_response, :string
  end
end
