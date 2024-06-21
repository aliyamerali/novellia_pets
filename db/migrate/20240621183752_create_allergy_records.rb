class CreateAllergyRecords < ActiveRecord::Migration[7.1]
  def change
    create_table :allergy_records do |t|
      t.string :name
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
