# == Schema Information
#
# Table name: attendees
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Attendee, type: :model do
  context 'validations' do
    subject { create(:attendee) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  context 'associations' do
    it { should have_many(:show_attendees).dependent(:destroy) }
    it { should have_many(:shows).through(:show_attendees) }
    it { should have_many(:votes).dependent(:destroy) }
  end

  describe '.find_by_normalized_email' do
    let!(:attendee) { create(:attendee, email: "test.email@gmail.com") }

    it 'finds the attendee by normalized email' do
      expect(Attendee.find_by_normalized_email("testemail@gmail.com")).to eq(attendee)
    end

    it 'returns nil for a non-existent email' do
      expect(Attendee.find_by_normalized_email("nonexistent@gmail.com")).to be_nil
    end
  end
end
