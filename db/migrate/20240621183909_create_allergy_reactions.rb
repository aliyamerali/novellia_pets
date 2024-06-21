class CreateAllergyReactions < ActiveRecord::Migration[7.1]
  def change
    create_table :allergy_reactions do |t|
      t.integer :reaction, :null => false
      t.integer :severity, :null => false
      t.references :allergy_record, null: false, foreign_key: true

      t.timestamps
    end
  end
end
