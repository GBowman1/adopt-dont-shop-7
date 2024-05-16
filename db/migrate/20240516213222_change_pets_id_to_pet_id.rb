class ChangePetsIdToPetId < ActiveRecord::Migration[7.1]
  def change
    rename_column :application_pets, :pets_id, :pet_id
  end
end
