class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :title
      t.text :description
      t.integer :course_hours
      t.string :course_days
      t.date :to_date
      t.date :from_date
      t.string :course_type
      t.string :price
      t.string:categories
      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
