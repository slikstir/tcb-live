# == Schema Information
#
# Table name: shows
#
#  id            :bigint           not null, primary key
#  audience_size :integer
#  code          :string
#  date          :datetime
#  name          :string           not null
#  state         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  template_id   :bigint
#
# Indexes
#
#  index_shows_on_template_id  (template_id)
#
require 'rails_helper'

RSpec.describe Show, type: :model do
  context 'associations' do
    it { should have_many(:attendees) }
    it { should have_many(:links) }
    it { should belong_to(:template).optional }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
  end
end
