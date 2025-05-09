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
FactoryBot.define do
  factory :show_attendee do
    
  end
end
