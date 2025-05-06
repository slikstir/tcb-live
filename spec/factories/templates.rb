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
FactoryBot.define do
  factory :template do
    name { "Default Template" }
  end
end
