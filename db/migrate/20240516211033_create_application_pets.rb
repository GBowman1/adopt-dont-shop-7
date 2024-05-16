class CreateApplicationPets < ActiveRecord::Migration[7.1]
  def change
    create_table :application_pets do |t|
      

      t.timestamps
    end
  end
end
