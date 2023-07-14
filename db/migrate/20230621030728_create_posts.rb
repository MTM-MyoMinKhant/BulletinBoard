class CreatePosts < ActiveRecord::Migration[7.0]
  def up
    create_table :posts do |t|
      t.string :title , limit: 255
      t.text :description
      t.integer :status
      t.belongs_to :create_user, foreign_key: { to_table: :users }
      t.belongs_to :updated_user, foreign_key: { to_table: :users }
      t.belongs_to :deleted_user, foreign_key: { to_table: :users }
      t.timestamps
      t.datetime :deleted_at
    end
  end

  def down
    drop_table :posts
  end
end
