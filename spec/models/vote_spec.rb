# == Schema Information
#
# Table name: votes
#
#  id                  :bigint           not null, primary key
#  count               :integer          default(1), not null
#  eligible            :boolean          default(TRUE)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  attendee_id         :bigint
#  choice_id           :bigint           not null
#  live_stream_poll_id :bigint
#  poll_id             :bigint           not null
#
# Indexes
#
#  index_votes_on_attendee_id          (attendee_id)
#  index_votes_on_choice_id            (choice_id)
#  index_votes_on_live_stream_poll_id  (live_stream_poll_id)
#  index_votes_on_poll_id              (poll_id)
#
# Foreign Keys
#
#  fk_rails_...  (attendee_id => attendees.id)
#  fk_rails_...  (choice_id => choices.id)
#  fk_rails_...  (poll_id => polls.id)
#
require 'rails_helper'

RSpec.describe Vote, type: :model do
  context 'associations' do
    it { should belong_to(:attendee).optional }
    it { should belong_to(:choice) }
    it { should belong_to(:poll) }
    it { should belong_to(:live_stream_poll).optional }
  end
end
