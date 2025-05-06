# == Schema Information
#
# Table name: links
#
#  id         :bigint           not null, primary key
#  label      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  show_id    :bigint           not null
#
# Indexes
#
#  index_links_on_show_id  (show_id)
#
# Foreign Keys
#
#  fk_rails_...  (show_id => shows.id)
#
require 'rails_helper'

RSpec.describe Link, type: :model do
  context 'associations' do
    it { should belong_to(:show) }
  end

  context 'validations' do
    it { should validate_presence_of(:label) }
    it { should validate_presence_of(:url) }
  end
end
