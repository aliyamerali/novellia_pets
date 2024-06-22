class AddCreatedByToPets < ActiveRecord::Migration[7.1]
  def change
    add_column :pets, :created_by, :string, null: false, default: 'system'
  end
end
