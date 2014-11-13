class CreateVisitors < ActiveRecord::Migration
  def self.up
    create_table :visitors do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :view
      t.timestamps
    end
  end

  def self.down
    drop_table :visitors
  end
end
