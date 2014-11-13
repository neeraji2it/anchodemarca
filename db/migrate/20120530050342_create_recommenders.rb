class CreateRecommenders < ActiveRecord::Migration
  def self.up
    create_table :recommenders do |t|
      t.integer :user_id
      t.integer :recommender_id
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :recommenders
  end
end
