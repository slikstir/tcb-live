class CreateTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :templates do |t|
      t.string :name
      t.string :heading_bg_color
      t.string :heading_text_color
      t.string :light_page_bg_color
      t.string :light_page_titles
      t.string :light_page_subtitles
      t.string :dark_page_bg_color
      t.string :dark_page_titles
      t.string :dark_page_subtitles
      t.string :choice_color
      t.string :choice_title_color
      t.string :choice_subtitle_color
      t.string :choice_outline
      t.string :choice_selected_outline
      t.string :vote_color
      t.string :vote_outline_color
      t.string :vote_text_color
      t.string :log_out_text_color
      t.string :log_out_color
      t.string :log_out_outline_color
      t.text   :google_fonts_embed
      t.text   :font_family_1
      t.text   :font_family_2
      t.timestamps
    end
  end
end
