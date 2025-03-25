# == Schema Information
#
# Table name: choices
#
#  id         :bigint           not null, primary key
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
class Choice < ApplicationRecord
  belongs_to :poll
  has_one :show, through: :poll
  has_many :votes, dependent: :destroy

  validates :title, presence: true
  validates :sort, uniqueness: { scope: :poll_id }, allow_blank: true

  has_one_attached :image


end
