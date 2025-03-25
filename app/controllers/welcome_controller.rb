class WelcomeController < ApplicationController
  def index
    @attendee = current_attendee || Attendee.new
  end

  def log_out
    session[:attendee_id] = nil
    redirect_to root_path
  end
end
