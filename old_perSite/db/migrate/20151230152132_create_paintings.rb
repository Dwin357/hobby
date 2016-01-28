class CreatePaintings < ActiveRecord::Migration
  def change
    create_table :paintings do |t|
      t.string :artist_name
      t.integer :owner_id
      t.text :description
      t.string :image
      t.date :aquisition_date

      t.timestamps null: false
    end
  end
end
