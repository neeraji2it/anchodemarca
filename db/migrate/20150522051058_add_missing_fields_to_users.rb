class AddMissingFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :landline, :string
    add_column :users, :extension, :string
  end

  def self.down
    remove_column :users, :landline
    remove_column :users, :extension
  end
end
