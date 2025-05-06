# == Schema Information
#
# Table name: choices
#
#  id         :bigint           not null, primary key
#  icon       :string
#  sort       :string
#  subtitle   :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  poll_id    :bigint           not null
#
# Indexes
#
#  index_choices_on_poll_id  (poll_id)
#
# Foreign Keys
#
#  fk_rails_...  (poll_id => polls.id)
#
require 'rails_helper'

RSpec.describe Choice, type: :model do
  context 'associations' do
    it { should belong_to(:poll) }
    it { should have_many(:votes) }
  end

  context 'validations' do
    it { should validate_presence_of(:title) }
  end
end
