# == Schema Information
#
# Table name: attendees
#
#  id         :bigint           not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Attendee < ApplicationRecord
  has_many :show_attendees, dependent: :destroy
  has_many :shows, through: :show_attendees
  has_many :votes, dependent: :destroy

  validates :name, :email, presence: true
  validates :email, uniqueness: true

  before_save      :normalize_email

  attribute :show_code, :string

  def self.find_by_normalized_email(email)
    return nil if email.blank? 
    
    normalized = normalize_gmail(email)
    find_by("LOWER(email) = ?", normalized)
  end

  def self.normalize_gmail(email)
    return email.downcase unless email.match?(/@gmail\.com\z/i)

    local, domain = email.split("@")
    local.gsub!(".", "") # Remove dots in the local part
    "#{local}@#{domain}".downcase
  end

  def voted_for(poll)
    poll.votes.where(attendee: self).exists?
  end

  def answer_for(poll)
    poll.votes.find_by(attendee: self)&.choice&.title || "No answer"
  end

  private

  def normalize_email
    self.email = self.class.normalize_gmail(email)
  end

end
