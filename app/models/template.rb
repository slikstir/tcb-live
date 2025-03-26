# == Schema Information
#
# Table name: templates
#
#  id                      :bigint           not null, primary key
#  choice_color            :string
#  choice_outline          :string
#  choice_selected_outline :string
#  choice_subtitle_color   :string
#  choice_title_color      :string
#  dark_page_bg_color      :string
#  dark_page_subtitles     :string
#  dark_page_titles        :string
#  font_family_1           :text
#  font_family_2           :text
#  google_fonts_embed      :text
#  heading_bg_color        :string
#  heading_text_color      :string
#  light_page_bg_color     :string
#  light_page_subtitles    :string
#  light_page_titles       :string
#  log_out_color           :string
#  log_out_outline_color   :string
#  log_out_text_color      :string
#  name                    :string
#  vote_color              :string
#  vote_outline_color      :string
#  vote_text_color         :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Template < ApplicationRecord
  has_one_attached :dark_page_bg
  has_one_attached :light_page_bg

  before_save :purge_dark_page_bg, if: -> { ActiveModel::Type::Boolean.new.cast(remove_dark_page_bg) }
  before_save :purge_light_page_bg, if: -> { ActiveModel::Type::Boolean.new.cast(remove_light_page_bg) }

  before_create :initialize_values

  validates :name, presence: true, uniqueness: true

  attr_accessor :remove_dark_page_bg
  attr_accessor :remove_light_page_bg

  private

  def purge_dark_page_bg
    dark_page_bg.purge_later
  end

  def purge_light_page_bg
    light_page_bg.purge_later
  end

  def initialize_values
    self.heading_bg_color        = '#D80118'
    self.heading_text_color      = '#FFCB0A'

    self.choice_color            = '#D80118'
    self.choice_outline          = '#B70215'
    self.choice_selected_outline = '#FFCB0a'
    self.choice_subtitle_color   = '#FFCB0a'
    self.choice_title_color      = '#FFFFFF'

    self.dark_page_bg_color      = '#000000'
    self.dark_page_subtitles     = '#FFFFFF'
    self.dark_page_titles        = '#FFCB0A'

    self.light_page_bg_color     = '#FFCB0A'
    self.light_page_subtitles    = '#FFFFFF'
    self.light_page_titles       = '#D80118'
    self.log_out_color           = '#000000'
    self.log_out_outline_color   = '#CCCCCC'
    self.log_out_text_color      = '#FFCB0A'

    self.vote_color              = '#FFCBOA'
    self.vote_outline_color      = '#C49C04'
    self.vote_text_color         = '#D80118'
  end
  
end
