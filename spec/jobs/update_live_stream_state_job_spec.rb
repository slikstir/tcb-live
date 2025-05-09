require 'rails_helper'

RSpec.describe UpdateLiveStreamStateJob, type: :job do
  let(:live_stream) { create(:live_stream, show: create(:show), state: 'closed') }

  it 'broadcasts page reload when state changes' do
    expect(live_stream).to receive(:broadcast_page_reload)
    live_stream.update(state: 'open')
  end
  
  it 'updates the live stream state after a delay' do
    expect {
      described_class.perform_now(live_stream, 'open')
    }.to change { live_stream.reload.state }.from('closed').to('open')
  end
end
