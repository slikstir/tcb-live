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
class LiveStreamPoll < ApplicationRecord
  belongs_to :live_stream
  belongs_to :poll
  
  def stream_delay
    if self[:stream_delay].present?
      self[:stream_delay].to_i
    else
      self.live_stream.stream_delay
    end
  end

end
