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
  pending "add some examples to (or delete) #{__FILE__}"
end
