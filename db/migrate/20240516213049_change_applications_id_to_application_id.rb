class ChangeApplicationsIdToApplicationId < ActiveRecord::Migration[7.1]
  def change
    rename_column :application_pets, :applications_id, :application_id
  end
end
