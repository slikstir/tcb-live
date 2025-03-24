# == Schema Information
#
# Table name: links
#
#  id         :bigint           not null, primary key
#  label      :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  show_id    :bigint           not null
#
# Indexes
#
#  index_links_on_show_id  (show_id)
#
# Foreign Keys
#
#  fk_rails_...  (show_id => shows.id)
#
class Link < ApplicationRecord
  belongs_to :show

  validate :url_must_be_valid
  validates :label, :url, presence: true

  private

  def url_must_be_valid
    return if url.blank?

    uri = URI.parse(url)
    unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      errors.add(:url, "must be a valid HTTP or HTTPS URL")
    end
  rescue URI::InvalidURIError
    errors.add(:url, "must be a valid URL")
  end
end
