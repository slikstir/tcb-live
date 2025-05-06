# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  kind       :string
#  question   :string
#  sort       :integer          default(0)
#  state      :string           default("closed")
#  subtitle   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  show_id    :bigint           not null
#
# Indexes
#
#  index_polls_on_show_id  (show_id)
#
# Foreign Keys
#
#  fk_rails_...  (show_id => shows.id)
#
require 'rails_helper'

RSpec.describe Poll, type: :model do
  context 'associations' do
    it { should belong_to(:show) }
    it { should have_many(:choices) }
    it { should have_many(:votes) }
  end

  context 'validations' do
    it { should validate_presence_of(:question) }
  end

  context 'default values' do
    it 'sets default state to closed' do
      poll = Poll.new
      expect(poll.state).to eq('closed')
    end

    it 'sets default sort to 0' do
      poll = Poll.new
      expect(poll.sort).to eq(0)
    end
  end
end
