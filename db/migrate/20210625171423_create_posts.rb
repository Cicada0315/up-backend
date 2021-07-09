class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.string :files
      t.integer :likes, array:true, default: []

      t.timestamps
    end
  end
end
