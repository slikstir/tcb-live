# == Schema Information
#
# Table name: shows
#
#  id            :bigint           not null, primary key
#  audience_size :integer
#  code          :string
#  date          :datetime
#  name          :string           not null
#  state         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  template_id   :bigint
#
# Indexes
#
#  index_shows_on_template_id  (template_id)
#
require 'rails_helper'

RSpec.describe Show, type: :model do
  context 'associations' do
    it { should have_many(:attendees) }
    it { should have_many(:links) }
    it { should belong_to(:template).optional }
  end

  context 'validations' do
    let!(:existing_show) { create(:show, code: 'ABC123') }
    let!(:live_stream) { create(:live_stream, show: existing_show, code: 'XYZ789') }

    it { should validate_presence_of(:name) }

    it 'is invalid if the code is taken by another Show' do
      show = build(:show, code: 'ABC123')
      expect(show).not_to be_valid
      expect(show.errors[:code]).to include('has already been taken in Show')
    end

    it 'is invalid if the code is taken by a LiveStream' do
      show = build(:show, code: 'XYZ789')
      expect(show).not_to be_valid
      expect(show.errors[:code]).to include('has already been taken in LiveStream')
    end

    it 'is valid if the code is unique across both models' do
      show = build(:show, code: 'DEF456')
      expect(show).to be_valid
    end
  end
end
