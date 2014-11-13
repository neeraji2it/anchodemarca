class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable
      t.string :user_name
      t.string :role
      t.string :surname
      t.datetime :date_of_birth
      t.integer :document_num
      t.string :document_type
      t.text :about_me
      t.string :retrived_title
      t.string :currently_studying
      t.string :current_occupation
      t.string :occupation
      t.string :creative_am
      t.string :participate_in_trining
      t.string :layout_work
      t.string :invite_private_calls
      t.string :outstanding_releave
      t.string :skills
      t.string :receive_news
      t.string :company_name
      t.integer :charge
      t.string :provision
      t.text :class_description
      t.string :avatar_file_name
      t.string :avatar_content_type
      t.integer :avatar_file_size
      t.string :working_arrangements
      t.string :name
      t.string :country
      t.string :city
      t.string :formal_duites
      t.string :position
      t.string :laboral_disposition
      t.string :schedule
      t.string :phone
      t.string :sex
      t.text :text_accept
      t.integer:subscription,:default => 0
      t.integer:post_work,:default => 0
      t.integer:post_class,:default => 0
      t.integer:recommendations,:default => 0
      t.integer :country_id
      t.integer :city_id
      t.string :total
      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    drop_table :users
  end
end
