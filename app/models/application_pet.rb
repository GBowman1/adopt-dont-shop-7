class ApplicationPet < ApplicationRecord
    belongs_to :application
    belongs_to :pet

    validates :application_id, presence: true
    validates :pet_id, presence: true
    validates :approved, inclusion: { in: [true, false] }, allow_nil: true
end