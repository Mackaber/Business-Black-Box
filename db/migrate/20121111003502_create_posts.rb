class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.references :user
      t.string :category
      t.integer :voteup
      t.integer :votedown

      t.timestamps
    end
    add_index :posts, :user_id
  end
end
