class CreateProjectLikes < ActiveRecord::Migration
  def self.up
    create_table :project_likes do |t|
      t.integer :user_id
      t.integer :bid_id
      t.integer :project_id
      t.integer :course_id
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :project_likes
  end
end
