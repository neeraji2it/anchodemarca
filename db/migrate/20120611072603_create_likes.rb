class CreateLikes < ActiveRecord::Migration
  def self.up
    create_table :likes do |t|
      t.integer :user_id
      t.integer :liker_id
      t.integer :course_id
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :likes
  end
end
