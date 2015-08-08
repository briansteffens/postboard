class SetIsListedDefaultOnBoards < ActiveRecord::Migration
  def change
    change_column_default(:boards, :is_listed, true)
  end
end
