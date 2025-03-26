module Admin
  class TemplatesController < AdminController
    def index 
      @templates = Template.all
    end

    def show
      @template = Template.find(params[:id])
    end

    def new
      @template = Template.new
    end

    def create
      @template = Template.new(template_params)
      if @template.save
        redirect_to admin_template_path(@template), notice: "Template created"
      else
        render :new
      end
    end

    def edit
      @template = Template.find(params[:id])
    end

    def update
      @template = Template.find(params[:id])
      if @template.update(template_params)
        redirect_to admin_template_path(@template), notice: "Template updated"
      else
        render :edit
      end
    end

    def destroy
      @template = Template.find(params[:id])
      @template.destroy
      redirect_to admin_templates_path, notice: "Template deleted"
    end

    private 

    def template_params 
      params.require(:template).permit(
        :name, :light_page_bg_color, :light_page_titles, 
        :light_page_subtitles, :dark_page_bg_color, :dark_page_titles, 
        :dark_page_subtitles, :choice_color, :choice_title_color, 
        :choice_subtitle_color, :choice_outline, 
        :choice_selected_outline, :vote_color, 
        :vote_outline_color, :vote_text_color, 
        :log_out_text_color, :log_out_color, 
        :log_out_outline_color, :google_fonts_embed, 
        :font_family_1, :font_family_2, :dark_page_bg, :light_page_bg,
        :remove_dark_page_bg, :remove_light_page_bg
      )
    end
  end
end
