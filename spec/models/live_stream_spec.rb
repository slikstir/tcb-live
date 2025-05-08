# == Schema Information
#
# Table name: live_streams
#
#  id           :bigint           not null, primary key
#  description  :string
#  name         :string
#  stream_delay :integer          default(0), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  show_id      :bigint           not null
#
# Indexes
#
#  index_live_streams_on_show_id  (show_id)
#
# Foreign Keys
#
#  fk_rails_...  (show_id => shows.id)
#
require 'rails_helper'

RSpec.describe LiveStream, type: :model do
  context 'associations' do
    it { should belong_to(:show) }
    it { should have_many(:live_stream_polls) }
  end

  context 'validations' do
    let!(:show) { create(:show, code: 'XYZ789') }
    let!(:existing_live_stream) { create(:live_stream, show: show, code: 'GHI101') }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }


    it 'is invalid if the code is taken by another LiveStream' do
      live_stream = build(:live_stream, show: show, code: 'GHI101')
      expect(live_stream).not_to be_valid
      expect(live_stream.errors[:code]).to include('has already been taken in LiveStream')
    end

    it 'is invalid if the code is taken by a Show' do
      live_stream = build(:live_stream, show: show, code: 'XYZ789')
      expect(live_stream).not_to be_valid
      expect(live_stream.errors[:code]).to include('has already been taken in Show')
    end

    it 'is valid if the code is unique across both models' do
      live_stream = build(:live_stream, show: show, code: 'JKL202')
      expect(live_stream).to be_valid
    end
  end

  context 'after_create' do
    include_context "with a live show and two multiple-choice polls"
    let(:live_stream) { create(:live_stream, show: show) }

    it 'creates live_stream_polls for each poll in the show' do
      expect(live_stream.live_stream_polls.count).to eq(2)
    end
  end
end
