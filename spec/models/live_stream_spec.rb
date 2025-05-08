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
require 'rails_helper'

RSpec.describe LiveStream, type: :model do
  context 'associations' do
    it { should belong_to(:show) }
    it { should have_many(:live_stream_polls) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
  end

end
