class CreateGuitars < ActiveRecord::Migration[7.1]
  def change
    create_table :guitars do |t|
      t.string :name
      t.integer :year
      t.float :price
      t.integer :user_id

      t.timestamps
    end
  end
end
