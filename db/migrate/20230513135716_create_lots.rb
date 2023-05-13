class CreateLots < ActiveRecord::Migration[7.0]
  def change
    create_table :lots do |t|
      t.string :code
      t.date :start_date
      t.date :finish_date
      t.integer :start_bid
      t.integer :increase_bid
      t.integer :started_by
      t.integer :finished_by
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
