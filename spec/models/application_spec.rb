require "rails_helper"

RSpec.describe Application, type: :model do
    describe "relationships" do
        it { should have_many :application_pets}
        it { should have_many(:pets).through(:application_pets) }
    end

    describe 'instance methods' do
        it 'can add pet' do
            @app = Application.create!(
                name: "Chee Lee",
                street_address: "123 street",
                city: "New Orleans",
                state: "Louisana",
                zip_code: "12345",
                description: "I will love that dog till I die",
                status: "In Progress",
            )
            @shelter_1 = Shelter.create(name: "Aurora shelter", city: "Aurora, CO", foster_program: false, rank: 9)
            @hazel = @shelter_1.pets.create!(
                name: "Hazel",
                breed: "German Shepherd",
                age: 5,
                adoptable: true
            )
            @app.add_pet(@hazel)

            expect(@app.pets).to eq([@hazel])
        end
    end
end