class AddPasswordDigestToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :password_digest, :string
  end
end
