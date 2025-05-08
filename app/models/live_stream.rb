# == Schema Information
#
# Table name: live_streams
#
#  id           :bigint           not null, primary key
#  description  :string
#  name         :string
#  stream_delay :integer
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

  validates :name, presence: true
  validates :stream_delay, 
              numericality: { only_integer: true, greater_than: 0 }, 
              allow_nil: false  
end
