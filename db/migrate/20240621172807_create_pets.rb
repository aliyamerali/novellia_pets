class CreatePets < ActiveRecord::Migration[7.1]
  def change
    create_table :pets do |t|
      t.string :name, :null => false
      t.integer :species, :null => false
      t.string :owner_first, :null => false
      t.string :owner_last, :null => false
      t.date :date_of_birth, :null => false

      t.timestamps
    end
  end
end
