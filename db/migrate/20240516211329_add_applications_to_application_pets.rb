class AddApplicationsToApplicationPets < ActiveRecord::Migration[7.1]
  def change
    add_reference :application_pets, :applications, foreign_key: true
  end
end
