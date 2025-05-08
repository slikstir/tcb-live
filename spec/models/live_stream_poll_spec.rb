# == Schema Information
#
# Table name: live_stream_polls
#
#  id             :bigint           not null, primary key
#  count_votes    :boolean          default(FALSE)
#  stream_delay   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  live_stream_id :bigint           not null
#  poll_id        :bigint           not null
#
# Indexes
#
#  index_live_stream_polls_on_live_stream_id  (live_stream_id)
#  index_live_stream_polls_on_poll_id         (poll_id)
#
# Foreign Keys
#
#  fk_rails_...  (live_stream_id => live_streams.id)
#  fk_rails_...  (poll_id => polls.id)
#
require 'rails_helper'

RSpec.describe LiveStreamPoll, type: :model do
  context 'associations' do
    it{ should belong_to(:live_stream) }
    it{ should belong_to(:poll) }
  end

  context 'validations' do

  end

  describe '#stream_delay' do
    context 'when stream_delay is not set' do
      let(:show) { create(:show) }
      let(:live_stream) { create(:live_stream, stream_delay: 10, show: show) }
      let(:live_stream_poll) { create(:live_stream_poll, 
                                live_stream: live_stream, 
                                poll: create(:multiple_choice_poll, 
                                show: show), stream_delay: nil) }

      it 'returns the live_stream#stream_delay' do 
        expect(live_stream_poll.stream_delay).to eq(10)
      end
    end

    context 'when stream_delay is set' do
      let(:show) { create(:show) }
      let(:live_stream) { create(:live_stream, stream_delay: 10, show: show) }
      let(:live_stream_poll) { create(:live_stream_poll, 
                                live_stream: live_stream, 
                                poll: create(:multiple_choice_poll, 
                                show: show), stream_delay: 15) }

      it 'returns the set stream_delay' do 
        expect(live_stream_poll.stream_delay).to eq(15)
      end
    end
  end
end
