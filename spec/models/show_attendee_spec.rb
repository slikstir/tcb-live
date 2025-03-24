# == Schema Information
#
# Table name: show_attendees
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  attendee_id :bigint           not null
#  show_id     :bigint           not null
#
# Indexes
#
#  index_show_attendees_on_attendee_id  (attendee_id)
#  index_show_attendees_on_show_id      (show_id)
#
# Foreign Keys
#
#  fk_rails_...  (attendee_id => attendees.id)
#  fk_rails_...  (show_id => shows.id)
#
require 'rails_helper'

RSpec.describe ShowAttendee, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
