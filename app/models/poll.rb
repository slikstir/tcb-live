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
class Poll < ApplicationRecord

  STATES = %w[closed open].freeze
  KINDS = {
    multiple_choice: "Multiple Choice",
    yes_no: "Yes/No"
  }.freeze
  
  belongs_to :show
  has_many :choices, -> { order(sort: :asc) }

  accepts_nested_attributes_for :choices, allow_destroy: true

  after_initialize :set_defaults, if: :new_record?

  

  private

  def set_defaults
    self.sort = show.polls.maximum(:sort).to_i + 1
  end

end
