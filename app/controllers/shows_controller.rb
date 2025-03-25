class ShowsController < ApplicationController
  before_action :check_for_attendee_logged_in

  def show
    @show = Show.find(params[:id])
  end
end
