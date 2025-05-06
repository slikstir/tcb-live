class ShowsController < ApplicationController
  before_action :check_for_attendee_logged_in
  before_action :check_if_attendee_part_of_show
  before_action :find_settings

  def show
    @show = Show.find(params[:id])

    if @show.live? && @show.active_polls?
      # Find the first open poll that
      # is not already voted by the attendee
      # Or the last poll if all polls are voted
      @poll = @show.polls.open.where.not(id: @current_attendee.votes.pluck(:poll_id)).first || @show.polls.open.last
      @vote = Vote.new
    end

    redirect_to root_path, alert: "Sorry, this show isn't currently available" unless @show.public?
  end

  private

  def check_if_attendee_part_of_show
    unless @current_attendee.shows.include?(Show.find(params[:id]))
      redirect_to root_path, alert: "Please log in with the provided show code"
    end
  end
end
