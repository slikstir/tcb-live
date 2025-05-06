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
FactoryBot.define do
  factory :poll do
    factory :multiple_choice_poll do
      kind { "multiple_choice" }
      question { "What is your favorite color?" }
      subtitle { "Choose one" }
    end

    factory :yes_no_poll do
      kind { "yes_no" }
      question { "Do you like ice cream?" }
      subtitle { "Answer yes or no" }
    end
  end
end
