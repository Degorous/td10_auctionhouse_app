class AddColumsToLot < ActiveRecord::Migration[7.0]
  def change
    add_column :lots, :bid, :integer
    add_reference :lots, :bid_user, foreign_key: { to_table: :users}
  end
end
