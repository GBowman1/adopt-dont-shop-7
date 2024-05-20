class AddApprovalStatusToApplicationPets < ActiveRecord::Migration[7.1]
  def change
    add_column :application_pets, :approved, :boolean
  end
end
