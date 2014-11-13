class CreateUserViews < ActiveRecord::Migration
  def self.up
    create_table :user_views do |t|
      t.integer :user_id
      t.integer :viewer_id
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :user_views
  end
end
