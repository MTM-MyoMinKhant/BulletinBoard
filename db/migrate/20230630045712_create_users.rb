class CreateUsers < ActiveRecord::Migration[7.0]
  def up
    create_table :users do |t|
      t.string :name
      t.string :email,              null: false, default: ""
      t.string :password_digest , null: false, default: ""
      t.integer :role
      t.integer :phone
      t.string :address , limit: 255
      t.string :avatar
      t.date :dob
      t.belongs_to :create_user, foreign_key: { to_table: :users }
      t.belongs_to :updated_user, foreign_key: { to_table: :users }
      t.belongs_to :deleted_user, foreign_key: { to_table: :users } 
      t.timestamps
      t.datetime :deleted_at
    end
  end

  def down
    drop_table :users
  end
end

