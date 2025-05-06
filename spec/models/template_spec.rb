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
require 'rails_helper'

RSpec.describe Template, type: :model do
  context 'associations' do
    it { should have_one_attached(:dark_page_bg) }
    it { should have_one_attached(:light_page_bg) }
    it { should have_many(:shows) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
