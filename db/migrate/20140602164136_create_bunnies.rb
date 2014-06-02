class CreateBunnies < ActiveRecord::Migration
  def change
    create_table :bunnies do |t|
      t.string :name
      t.string :age
      t.string :color
      t.string :breed
      t.string :favorite_comic_book

      t.timestamps
    end
  end
end
