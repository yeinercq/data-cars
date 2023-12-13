class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :brand
      t.string :model
      t.decimal :price
      t.integer :production_year
      t.decimal :cylinder_capacity
      t.decimal :mileage

      t.timestamps
    end
    add_index :cars, :brand
    add_index :cars, :model
  end
end
