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

  belongs_to :template, optional: true

  before_save :destroy_votes, if: :reset_votes
  after_save :broadcast_page_reload, if: :saved_change_to_state?

  validates :name, presence: true

  STATES = %w[closed preshow live postshow archived].freeze

  attribute :reset_votes, :boolean

  accepts_nested_attributes_for :links, allow_destroy: true

  STATES.each do |state_name|
    define_method("#{state_name}?") do
      state == state_name
    end
  end

  def attendees_count
    attendees.count
  end

  def public?
    %w(preshow live postshow).include?(state)
  end

  def active_polls?
    polls.where(state: "open").any?
  end

  def as_json(options = {})
    super({
      except: [:created_at, :updated_at],
      methods: [:attendees_count]
    }.merge(options))
  end

  private

  def destroy_votes
    polls.each{|p| p.votes.destroy_all }
  end

  def broadcast_page_reload
    Turbo::StreamsChannel.broadcast_replace_to(
      "page_reload",
      target: "page_reload",
      partial: "shared/reload"
    )
  end

end
