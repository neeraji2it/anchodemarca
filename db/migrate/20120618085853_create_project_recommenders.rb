class CreateProjectRecommenders < ActiveRecord::Migration
  def self.up
    create_table :project_recommenders do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :course_id
      t.timestamps
    end
  end

  def self.down
    drop_table :project_recommenders
  end
end
