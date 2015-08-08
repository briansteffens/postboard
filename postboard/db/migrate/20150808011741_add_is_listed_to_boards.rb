class AddIsListedToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :is_listed, :boolean, null: false, default: false
  end
end
