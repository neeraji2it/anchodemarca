class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :topic
      t.string :categories
      t.string :status
      t.integer :payment
      t.datetime :start_date
      t.datetime :end_date
      t.text :description
      t.string :community
      t.string :allow_vote
      t.string :allow_customers
      t.string :creative_comment_pieces
      t.string :creative_comment_project

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end
