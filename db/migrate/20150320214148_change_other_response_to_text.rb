class ChangeOtherResponseToText < ActiveRecord::Migration
  def self.up
    change_column :responses, :other_response, :text, :limit => nil
  end
 
  def self.down
    change_column :responses, :other_response, :string
  end
end
