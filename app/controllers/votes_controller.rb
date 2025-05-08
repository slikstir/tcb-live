class VotesController < ApplicationController
  before_action :check_for_attendee_logged_in

  def create
    @vote = Vote.new(vote_params)
    @poll = Poll.find(vote_params[:poll_id])
    @show = @poll.show

    if @vote.save
      if @poll.live_stream_poll.present?
        redirect_to show_path(@show.live_stream.code), notice: "Your vote has been recorded"
      else
        redirect_to show_path(@show.code), notice: "Your vote has been recorded"
      end
    else
      render "shows/show"
    end
  end

  private

  def vote_params
    params.require(:vote).permit(
      :poll_id, :attendee_id, :choice_id, :count,
      :eligible, :live_stream_poll_id
    )
  end
end
