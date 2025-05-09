# == Schema Information
#
# Table name: live_streams
#
#  id           :bigint           not null, primary key
#  code         :string           default(""), not null
#  description  :string
#  name         :string
#  state        :string
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
FactoryBot.define do
  factory :live_stream do
    name { "Hella Awesome Twitch Stream" }
    code { "twitch" }
    stream_delay { 10 }
  end
end
