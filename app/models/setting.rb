# == Schema Information
#
# Table name: settings
#
#  id          :bigint           not null, primary key
#  code        :string
#  description :text
#  name        :string
#  value       :text
#  value_type  :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_settings_on_code  (code)
#
class Setting < ApplicationRecord
  validates :image, content_type: [ "image/png", "image/jpeg", "image/gif" ]

  has_one_attached :image
  has_rich_text :html

  default_scope { order(:name) }

  after_commit :broadcast_chud_checkpoint_time, if: -> { code == "chud_checkpoint_time" }

  VALUE_TYPES = %w[
    string
    text
    integer
    decimal
    image
    boolean
    html
  ]

  VALUE_TYPES.each do |vt|
    define_method("#{vt}?") do
      value_type == vt
    end
  end

  def value
    case value_type
    when "integer"
      super.to_i
    when "decimal"
      super.to_f
    when "boolean"
      super == "true"
    when "html"
      html
    else
      super
    end
  end

  def image_thumbnail
    image.variant(resize_to_limit: [ 150, 150 ]).processed
  end

  def image_medium
    image.variant(resize_to_limit: [ 500, 500 ]).processed
  end

  private
end
