class ShowsController < ApplicationController
  before_action :check_for_attendee_logged_in

  def show
    @show = Show.find(params[:id])

    if @show.live? && @show.active_polls? 
      @poll = @show.polls.open.first
      @vote = Vote.new
    end

    redirect_to root_path, alert: "Sorry, this show isn't currently available" unless @show.public?
  end
end
