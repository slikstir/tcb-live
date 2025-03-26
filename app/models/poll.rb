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
    'multiple_choice' => "Multiple Choice",
    'yes_no' => "Yes/No"
  }.freeze

  scope :open, -> { where(state: "open") }

  has_one_attached :image

  belongs_to :show
  has_many :choices, -> { order(sort: :asc) }, dependent: :destroy
  has_many  :votes, dependent: :destroy

  validates :kind, inclusion: { in: KINDS.keys }
  validates :state, inclusion: { in: STATES }
  validates :question, presence: true
  
  validates :sort, uniqueness: { scope: :show_id }

  accepts_nested_attributes_for :choices, allow_destroy: true

  after_initialize :set_defaults, if: :new_record?

  before_save :purge_image, if: :remove_image?
  before_save :destroy_votes, if: :reset_votes
  
  after_save :broadcast_page_reload, if: :saved_change_to_state?

  before_destroy :purge_image

  attribute :remove_image, :boolean
  attribute :reset_votes, :boolean

  KINDS.each do |key, val|
    define_method("#{key}?") do
      key == kind
    end
  end

  def winners
    max_votes = choices.map { |choice| choice.votes.count }.max
    choices.select { |choice| choice.votes.count == max_votes }
  end

  def as_json(options = {})
    super({
      except: [:created_at, :updated_at],
      methods: [:winners],
      include: {
        choices: {
          except: [:created_at, :updated_at],
          methods: []
        }
      }
    }.merge(options))
  end

  private
  
  def purge_image
    image.purge_later
  end

  def destroy_votes
    votes.destroy_all
  end

  def set_defaults
    self.sort = show.polls.maximum(:sort).to_i + 1
  end

  def broadcast_page_reload
    Turbo::StreamsChannel.broadcast_replace_to(
      "page_reload",
      target: "page_reload",
      partial: "shared/reload"
    )
  end

end
