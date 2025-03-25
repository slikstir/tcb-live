module Api
  class ChoicesController < ApiController
    before_action :set_records

    def index
      choices = @poll.choices.order(:sort)
      render json: choices.as_json(
        except: [:created_at, :updated_at]
      ), status: :ok
    end

    def show
      choice = @poll.choices.find_by(sort: params[:id])
      render json: choice, status: :ok
    rescue 
      render json: { error: "Choice not found" }, status: :not_found
    end

    def create
      choice = @poll.choices.new(choice_params)
      byebug
      if choice.save
        render json: choice, status: :created
      else
        render json: { error: choice.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    rescue 
      render json: { error: "Choice not found" }, status: :not_found
    end

    def update
      choice = @poll.choices.find_by(sort: params[:id])
      if choice.update(choice_params)
        render json: choice, status: :ok
      else
        render json: { error: choice.errors.full_messages.to_sentence }, status: :unprocessable_entity
      end
    rescue 
      render json: { error: "Choice not found" }, status: :not_found
    end

    def destroy
      choice = @poll.choices.find_by!(sort: params[:id])
      choice.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Choice not found" }, status: :not_found
    end
    

    private 

    def choice_params
      params.require(:choice).permit(
        :title, :subtitle
      )
    end

    def set_records
      @show = Show.find(params[:show_id])
      @poll = @show.polls.find_by(sort: params[:poll_id])
    end
  end
end