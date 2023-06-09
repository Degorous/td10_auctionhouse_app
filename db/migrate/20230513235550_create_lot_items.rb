class CreateLotItems < ActiveRecord::Migration[7.0]
  def change
    create_table :lot_items do |t|
      t.belongs_to :lot, null: false, foreign_key: true
      t.belongs_to :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
