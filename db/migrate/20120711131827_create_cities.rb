class CreateCities < ActiveRecord::Migration
  def self.up
    create_table :cities do |t|
      t.integer :country_id
      t.string :city

      t.timestamps
    end
  end

  def self.down
    drop_table :cities
  end
end
