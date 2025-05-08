# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  kind       :string
#  question   :string
#  sort       :integer          default(0)
#  state      :string           default("closed")
#  subtitle   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  show_id    :bigint           not null
#
# Indexes
#
#  index_polls_on_show_id  (show_id)
#
# Foreign Keys
#
#  fk_rails_...  (show_id => shows.id)
#
require 'rails_helper'

RSpec.describe Poll, type: :model do
  context 'associations' do
    it { should belong_to(:show) }
    it { should have_many(:choices) }
    it { should have_many(:votes) }
  end

  context 'validations' do
    it { should validate_presence_of(:question) }
  end

  context 'default values' do
    it 'sets default state to closed' do
      poll = Poll.new
      expect(poll.state).to eq('closed')
    end

    it 'sets default sort to 0' do
      poll = Poll.new
      expect(poll.sort).to eq(0)
    end

    context 'when kind is multiple_choice' do
      it 'creates a yes and a no choice by default' do
        poll = create(:yes_no_poll, show: create(:show))
        poll.save

        expect(poll.choices.count).to eq(2)
        expect(poll.choices.pluck(:title)).to include('Yes', 'No')
        expect(poll.choices.pluck(:icon)).to include('check-circle', 'x-circle')
      end
    end
  end

  context '#after_create' do
    let(:show) { create(:show) }
    let(:live_stream) { create(:live_stream, show: show) }

    context 'when there is a live stream' do
      it 'creates a live stream poll' do
        expect(show.polls.count).to eq(0)
        expect(live_stream.live_stream_polls.count).to eq(0)
        create(:multiple_choice_poll, show: show)
        expect(show.polls.count).to eq(1)
        expect(live_stream.live_stream_polls.count).to eq(1)
      end
    end
  end

  context "#after_delete" do
    context "when there is a live stream" do
      include_context "with a live show and two multiple-choice polls"
      let(:live_stream) { create(:live_stream, show: show) }

      it "deletes the live stream poll" do
        expect(show.polls.count).to eq(2)
        expect(live_stream.live_stream_polls.count).to eq(2)
        show.polls.first.destroy
        expect(show.polls.count).to eq(1)
        expect(live_stream.live_stream_polls.count).to eq(1)
      end
    end
  end
end
