require 'rails_helper'

RSpec.describe UpdateLiveStreamPollStateJob, type: :job do
  include_context 'with a live stream and two multiple-choice polls'
  let(:live_stream_poll) { live_stream.live_stream_polls.first }

  it 'broadcasts page reload when state changes' do
    expect(live_stream_poll).to receive(:broadcast_page_reload)
    live_stream_poll.update(state: 'open')
  end

  it 'updates the live stream poll state after a delay' do
    expect {
      described_class.perform_now(live_stream_poll, 'open')
    }.to change { live_stream_poll.reload.state }.from('closed').to('open')
  end
end