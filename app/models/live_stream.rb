# == Schema Information
#
# Table name: live_streams
#
#  id           :bigint           not null, primary key
#  code         :string           default(""), not null
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
class LiveStream < ApplicationRecord
  belongs_to :show
  has_many :live_stream_polls, dependent: :destroy
  has_many :polls, through: :live_stream_polls
  has_many :show_attendees, as: :attendable
  has_many :attendees, through: :show_attendees

  validates :name, :code, presence: true
  validates :stream_delay,
              numericality: { only_integer: true, greater_than_or_equal_to: 0 },
              allow_nil: false
  validates :code, unique_across_models: { models: [ Show ] }

  after_create :assign_live_stream_polls

  accepts_nested_attributes_for :live_stream_polls

  def attendees_count
    show_attendees.count
  end

  private

  def assign_live_stream_polls
    show.polls.each do |poll|
      live_stream_polls.create(poll: poll, stream_delay: nil)
    end
  end
end
