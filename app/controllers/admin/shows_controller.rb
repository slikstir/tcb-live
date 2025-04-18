module Admin
  class ShowsController < AdminController
    include Pagy::Backend

    before_action :find_records, only: [:edit, :create, :update, :new]
    
    def index
      @shows = Show.all
    end

    def show
      @show = Show.find(params[:id])
    end

    def new
      @show = Show.new
    end

    def create
      @show = Show.new(show_params)
    
      if @show.save
        redirect_to admin_show_path(@show), notice: 'Show was successfully created.'
      else
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace(@show, partial: 'admin/shows/form', locals: { show: @show }) }
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit
      @show = Show.find(params[:id])
    end

    def update
      @show = Show.find(params[:id])
    
      if @show.update(show_params)
        redirect_to admin_show_path(@show), notice: 'Show was successfully updated.'
      else
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace(@show, partial: 'admin/shows/form', locals: { show: @show }) }
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @show = Show.find(params[:id])
      @show.destroy
      redirect_to admin_shows_path, notice: 'Show was successfully destroyed.'
    end

    def attendees
      @show = Show.find(params[:id])
      @pagy, @attendees = pagy(@show.attendees)
    end

    private 

    def show_params
      params.require(:show).permit(
        :name, :template_id, :date, :reset_votes, 
        :state, :code, :audience_size, :image,
        links_attributes: [ :id, :label, :url, :_destroy]
      )
    end

    def find_records
      @templates = Template.all
    end
  end
end
