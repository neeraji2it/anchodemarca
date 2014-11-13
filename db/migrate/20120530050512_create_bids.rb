class CreateBids < ActiveRecord::Migration
  def self.up
    create_table :bids do |t|
      t.integer :project_id
      t.integer :user_id
      t.text :comment
      t.integer :bid_count, :default => 0
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :bids
  end
end
