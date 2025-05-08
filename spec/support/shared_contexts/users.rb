RSpec.shared_context "Logged into admin" do
  let(:user) { create(:user) }
  before { login_as(user) }
end
