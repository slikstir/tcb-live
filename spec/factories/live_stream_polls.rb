# == Schema Information
#
# Table name: live_stream_polls
#
#  id             :bigint           not null, primary key
#  count_votes    :boolean          default(FALSE)
#  stream_delay   :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  live_stream_id :bigint           not null
#  poll_id        :bigint           not null
#
# Indexes
#
#  index_live_stream_polls_on_live_stream_id  (live_stream_id)
#  index_live_stream_polls_on_poll_id         (poll_id)
#
# Foreign Keys
#
#  fk_rails_...  (live_stream_id => live_streams.id)
#  fk_rails_...  (poll_id => polls.id)
#
FactoryBot.define do
  factory :live_stream_poll do
    
  end
end
