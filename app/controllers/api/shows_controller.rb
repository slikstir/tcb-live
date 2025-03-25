module Api
  class ShowsController < ApiController
    def index
      shows = Show.all
      render json: shows, status: :ok
    end

    def show
      show = Show.find(params[:id])
      render json: show, status: :ok
    rescue 
      render json: { error: "Show not found" }, status: :not_found
    end

    def update
      show = Show.find(params[:id])
      if show.update(show_params)
        render json: show, status: :ok
      else
        render json: { error: show.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    rescue 
      render json: { error: "Show not found" }, status: :not_found
    end

    private 

    def show_params
      params.require(:show).permit(
        :state
      )
    end
  end
end