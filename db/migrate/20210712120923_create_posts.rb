class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :profile_id, null: false
      t.text :text, null: false
      t.timestamps
    end
  end
end
