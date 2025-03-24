module Admin
  class ShowsController < AdminController
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
        render :new
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
        render :edit
      end
    end

    def destroy
      @show = Show.find(params[:id])
      @show.destroy
      redirect_to admin_shows_path, notice: 'Show was successfully destroyed.'
    end

    private 

    def show_params
      params.require(:show).permit(
        :name, :template_id, :date, 
        :state, :code, :audience_size, :image
      )
    end


  end
end
