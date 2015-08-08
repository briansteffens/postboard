class AddUniqueUrlFragmentToBoards < ActiveRecord::Migration
  def change
    add_index :boards, [:url_fragment], unique: true
  end
end
