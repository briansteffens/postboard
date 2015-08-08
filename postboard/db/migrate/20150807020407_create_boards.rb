class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :url_fragment

      t.timestamps null: false
    end
  end
end
