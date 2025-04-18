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

  before_save :assign_next_sort, if: -> { sort.blank? }
  before_save :purge_image, if: :remove_image?
  before_save :purge_and_create_votes, if: :force_vote_count?

  before_destroy :purge_image

  has_one_attached :image

  attribute :remove_image, :boolean
  attribute :force_vote_count, :integer

  def votes_count
    votes.count
  end

  def as_json(options = {})
    super({
      methods: [ :votes_count ],
      except: [ :created_at, :updated_at, :poll_id ]
    }.merge(options))
  end

  private

  def purge_image
    image.purge_later
  end

  def purge_and_create_votes
    return if force_vote_count.blank?
    return if force_vote_count <= 0

    votes.destroy_all
    force_vote_count.times do
      votes.create(
        choice: self,
        poll: poll,
        attendee: nil
      )
    end
  end

  def assign_next_sort
    used_letters = self.class.where(poll_id: self.poll_id).pluck(:sort).compact.map(&:upcase).uniq.sort
    all_letters = ("A".."Z").to_a

    available_letters = all_letters - used_letters
    self.sort = available_letters.first if available_letters.any?
  end
end
