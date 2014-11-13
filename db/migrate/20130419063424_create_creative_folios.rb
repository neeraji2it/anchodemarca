class CreateCreativeFolios < ActiveRecord::Migration
  def self.up
    create_table :creative_folios do |t|
      t.integer :user_id
      t.string :folio_file_name
      t.string :folio_content_type
      t.integer :folio_file_size
      t.string :title
      t.string :technique
      t.timestamps
    end
  end

  def self.down
    drop_table :creative_folios
  end
end
