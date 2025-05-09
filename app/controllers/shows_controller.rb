class ShowsController < ApplicationController
  before_action :check_for_attendee_logged_in
  before_action :find_settings

  def show
    if find_show.blank?
      redirect_to root_path, alert: "Sorry, but a show with that code wasn't found"
      return
    end

    unless attendee_part_of_show?
      redirect_to root_path, alert: "Please log in with the provided show code"
      return
    end

    if @show.live? && @show.active_polls?
      # Find the first open poll that
      # is not already voted by the attendee
      # Or the last poll if all polls are voted
      if @live_stream.present?
        @poll = @live_stream.live_stream_polls.open.where.not(id: @current_attendee.votes.pluck(:live_stream_poll_id)).first.try(:poll) ||
                          @live_stream.live_stream_polls.open.last.try(:poll)
      else
        @poll = @show.polls.open.where.not(id: @current_attendee.votes.pluck(:poll_id)).first || @show.polls.open.last
      end
      @vote = Vote.new
    end

    redirect_to root_path, alert: "Sorry, this show isn't currently available" unless @show.public?
  end

  private

  def find_show
    @live_stream = LiveStream.find_by("LOWER(code) = ?", params[:code].downcase)
    if @live_stream.present?
      @show = @live_stream.show
    else
      @show = Show.find_by("LOWER(code) = ?", params[:code].downcase)
    end

    @show
  end

  def attendee_part_of_show?
    @show ||= find_show

    if (@show.present? && @show.attendees.include?(@current_attendee)) ||
        (@show.live_stream.present? && @show.live_stream.attendees.include?(@current_attendee))
      true
    else
      false
    end
  end
end
