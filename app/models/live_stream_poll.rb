# == Schema Information
#
# Table name: live_stream_polls
#
#  id             :bigint           not null, primary key
#  count_votes    :boolean          default(FALSE)
#  state          :string
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
  STATES = %w[closed open].freeze

  validates :state, inclusion: { in: STATES }

  belongs_to :live_stream
  belongs_to :poll


  default_scope { joins(:poll).order("polls.sort ASC") }
  scope :open, -> { where(state: "open") }

  after_initialize :set_defaults, if: :new_record?
  after_save :broadcast_page_reload, if: :saved_change_to_state?

  def stream_delay
    if self[:stream_delay].present?
      self[:stream_delay].to_i
    else
      self.live_stream.stream_delay
    end
  end

  private

  def set_defaults
    self.state = "closed"
  end

  def broadcast_page_reload
    Turbo::StreamsChannel.broadcast_replace_to(
      "live_stream_page_reload",
      target: "live_stream_page_reload",
      partial: "shared/reload"
    )
  end
end
