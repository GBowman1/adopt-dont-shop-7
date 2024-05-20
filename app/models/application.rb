class Application < ApplicationRecord
    has_many :application_pets
    has_many :pets, through: :application_pets

    validates :name, presence: true
    validates :street_address, presence: true
    
    def add_pet(pet)
        self.pets << pet
    end

    def approve_pet(pet)
        application_pet = ApplicationPet.find_by(application_id: self.id, pet_id: pet.id)
        application_pet.update(approved: true)
    end

    def reject_pet(pet)
        application_pet = ApplicationPet.find_by(application_id: self.id, pet_id: pet.id)
        application_pet.update(approved: false)
    end
end