class CreateVaccineRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :vaccine_records do |t|
      t.string :name, null: false
      t.date :date_administered, null: false
      t.references :pet, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
