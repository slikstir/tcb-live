RSpec.shared_context "with a live show and two multiple-choice polls" do
  let!(:show) { create(:show, state: 'live') }
  let!(:p1) { create(:multiple_choice_poll, show: show, state: 'open', sort: 1) }
  let!(:p1c1) { create(:choice, poll: p1, title: "Red") }
  let!(:p1c2) { create(:choice, poll: p1, title: "Blue") }
  let!(:p1c3) { create(:choice, poll: p1, title: "Green") }

  let!(:p2) { create(:multiple_choice_poll, question: "What's your favorite dino?", show: show, state: 'closed', sort: 2) }
  let!(:p2c1) { create(:choice, poll: p2, title: "T-Rex") }
  let!(:p2c2) { create(:choice, poll: p2, title: "Velociraptor") }
  let!(:p2c3) { create(:choice, poll: p2, title: "Reptar") }
end


RSpec.shared_context "with a live show with a yes-no poll" do
  let!(:show) { create(:show, state: 'live') }
  let!(:p1) { create(:yes_no_poll, show: show, state: 'open', sort: 1) }
  let!(:p1c1) { p1.choices.first }
  let!(:p1c2) { p1.choices.last }
end

RSpec.shared_context 'with a live stream and two multiple-choice polls' do
  include_context 'with a live show and two multiple-choice polls'

  let(:live_stream) { create(:live_stream, show: show, code: "twitchStream") }
end
