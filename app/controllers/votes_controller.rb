class VotesController < ApplicationController
  before_action :check_for_attendee_logged_in

  def create
    @vote = Vote.new(vote_params)
    @poll = Poll.find(vote_params[:poll_id])
    @show = @poll.show

    if @vote.save
      redirect_to show_path(@show.code), notice: "Your vote has been recorded"
    else
      render "shows/show"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(
      :poll_id, :attendee_id, :choice_id, :count
    )
  end
end
