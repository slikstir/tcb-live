# == Schema Information
#
# Table name: show_attendees
#
#  id                 :bigint           not null, primary key
#  attendable_type    :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  attendable_id      :bigint
#  attendee_id        :bigint           not null
#  deprecated_show_id :bigint
#
# Indexes
#
#  index_show_attendees_on_attendable          (attendable_type,attendable_id)
#  index_show_attendees_on_attendee_id         (attendee_id)
#  index_show_attendees_on_deprecated_show_id  (deprecated_show_id)
#
# Foreign Keys
#
#  fk_rails_...  (attendee_id => attendees.id)
#  fk_rails_...  (deprecated_show_id => shows.id)
#
require 'rails_helper'

RSpec.describe ShowAttendee, type: :model do
  context 'associations' do
    it { should belong_to(:attendee) }
    it { should belong_to(:attendable) }

    context 'polymorphic association' do
      it 'can belong to a Show' do
        show = create(:show)
        attendee = create(:attendee)
        show_attendee = create(:show_attendee, attendee: attendee, attendable: show)

        expect(show_attendee.attendable).to eq(show)
      end

      it 'can belong to a LiveStream' do
        live_stream = create(:live_stream, show: create(:show))
        attendee = create(:attendee)
        show_attendee = create(:show_attendee, attendee: attendee, attendable: live_stream)

        expect(show_attendee.attendable).to eq(live_stream)
      end
    end
  end
end
