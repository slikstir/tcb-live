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
