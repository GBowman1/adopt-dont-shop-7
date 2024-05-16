class AddPetsToApplicationPets < ActiveRecord::Migration[7.1]
  def change
    add_reference :application_pets, :pets, foreign_key: true
  end
end
