class CreateUserComments < ActiveRecord::Migration
  def self.up
    create_table :user_comments do |t|
      t.integer :user_id
      t.integer :commenter_id
      t.text :comment
      t.timestamps
    end
  end

  def self.down
    drop_table :user_comments
  end
end
