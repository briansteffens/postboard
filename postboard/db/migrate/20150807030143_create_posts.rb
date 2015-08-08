class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :board, index: true, foreign_key: true
      t.text :body

      t.timestamps null: false
    end
  end
end
