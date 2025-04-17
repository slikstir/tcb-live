# == Schema Information
#
# Table name: votes
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attendee_id :bigint
#  choice_id   :bigint           not null
#  poll_id     :bigint           not null
#
# Indexes
#
#  index_votes_on_attendee_id  (attendee_id)
#  index_votes_on_choice_id    (choice_id)
#  index_votes_on_poll_id      (poll_id)
#
# Foreign Keys
#
#  fk_rails_...  (attendee_id => attendees.id)
#  fk_rails_...  (choice_id => choices.id)
#  fk_rails_...  (poll_id => polls.id)
#
require 'rails_helper'

RSpec.describe Vote, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
