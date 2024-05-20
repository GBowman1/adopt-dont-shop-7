require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
    describe "relationships" do
        it { should belong_to :application}
        it { should belong_to :pet}
        it { should validate_presence_of :application_id}
        it { should validate_presence_of :pet_id}
        it { should validate_inclusion_of(:approved).in_array([true, false])}
    end

end