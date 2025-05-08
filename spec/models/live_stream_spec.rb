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
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:code) }

    it 'validates the uniqueness of code across both live streams AND shows'
  end

  context 'after_create' do
    include_context "with a live show and two multiple-choice polls"
    let(:live_stream) { create(:live_stream, show: show) }

    it 'creates live_stream_polls for each poll in the show' do
      expect(live_stream.live_stream_polls.count).to eq(2)
    end
  end
end
