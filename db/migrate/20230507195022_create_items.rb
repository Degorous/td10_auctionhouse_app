class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.string :weight
      t.string :width
      t.string :height
      t.string :depth
      t.string :code
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
