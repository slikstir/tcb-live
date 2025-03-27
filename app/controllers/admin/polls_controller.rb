module Admin
  class PollsController < AdminController
    before_action :set_poll, only: [:show, :edit, :update, :destroy]
    before_action :set_show

    def index
      @polls = @show.polls.order(:sort)
    end

    def new
      @poll = @show.polls.build
    end

    def create
      @poll = @show.polls.build(poll_params)
      if @poll.save
        redirect_to admin_show_polls_path(@show), notice: "Poll was successfully created."
      else
        render :new
      end
    end

    def show; end 
    
    def edit; end

    def update
      if @poll.update(poll_params)
        redirect_to admin_show_polls_path(@show), notice: "Poll was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @poll.destroy
      redirect_to admin_show_polls_path(@show), notice: "Poll was successfully deleted."
    end


    private 

    def poll_params
      params.require(:poll).permit(
        :question, :subtitle, :image, :reset_votes, 
        :sort, :state, :kind, :remove_image, 
        choices_attributes: [:id, :image, :title, :subtitle, :sort, :remove_image,  :_destroy])
    end

    def set_poll
      @poll = Poll.find(params[:id])
    end

    def set_show
      @show = Show.find(params[:show_id])
    end
  end
end
