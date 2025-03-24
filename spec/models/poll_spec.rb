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
  pending "add some examples to (or delete) #{__FILE__}"
end
