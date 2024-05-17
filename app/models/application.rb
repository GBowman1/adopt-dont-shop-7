class Application < ApplicationRecord
    has_many :application_pets
    has_many :pets, through: :application_pets

    validates :name, presence: true
    validates :street_address, presence: true
    
end