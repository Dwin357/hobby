class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :value
      t.integer :pointer

      t.timestamps null: false
    end
  end
end
