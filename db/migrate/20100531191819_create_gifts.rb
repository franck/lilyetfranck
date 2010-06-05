class CreateGifts < ActiveRecord::Migration
  def self.up
    create_table :gifts do |t|
      t.string :name
      t.string :link
      t.string :price
      t.integer :quantity
      t.string :pic
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :gifts
  end
end
