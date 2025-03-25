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
class Show < ApplicationRecord
  has_one_attached :image

  has_many :links, dependent: :destroy
  has_many :polls, -> {order(sort: :asc)}, dependent: :destroy
  has_many :show_attendees, dependent: :destroy
  has_many :attendees, through: :show_attendees

  validates :name, presence: true

  STATES = %w[closed open archived].freeze

  accepts_nested_attributes_for :links, allow_destroy: true

  def live?
    state == 'open'
  end

end
