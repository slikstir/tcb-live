module Api
  class PollsController < ApiController
    before_action :set_records

    def index
      polls = @show.polls.order(:sort)
      render json: polls, status: :ok
    end

    def show
      poll = @show.polls.find_by(sort: params[:id])
      render json: poll, status: :ok
    rescue 
      render json: { error: "Poll not found" }, status: :not_found
    end

    def update
      @poll = @show.polls.find_by(sort: params[:id])
      if @poll.update(poll_params)
        render json: @poll, status: :ok
      else
        render json: { error: @poll.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    rescue 
      render json: { error: "Poll not found" }, status: :not_found
    end

    private 

    def poll_params
      params.require(:poll).permit(
        :question, :subtitle, 
        :sort, :state, :kind, 
        :reset_votes,
        choices_attributes: [:id, :image, :title, :subtitle, :sort, :_destroy]
      )
    end

    def set_records
      @show = Show.find(params[:show_id])
    end

  end
end
