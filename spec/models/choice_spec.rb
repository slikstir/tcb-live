# == Schema Information
#
# Table name: choices
#
#  id         :bigint           not null, primary key
#  sort       :integer
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
  pending "add some examples to (or delete) #{__FILE__}"
end
