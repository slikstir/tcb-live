class AttendeesController < ApplicationController
  def create
    @attendee = Attendee.find_by_normalized_email(permitted_params[:email])
    @attendee = Attendee.new(email: permitted_params[:email]) if @attendee.blank?
    @attendee.name = permitted_params[:name]
    @attendee.save
    session[:email] = @attendee.email


    if (show = Show.find_by("LOWER(code) = ?", permitted_params[:show_code].downcase)).present?
      if !show.live?
        redirect_to root_path, alert: "Sorry, but that show isn't live"
      else 
        show.attendees << @attendee unless show.attendees.include? @attendee
        session[:show_code] = permitted_params[:show_code].downcase

        redirect_to show_path(show), notice: "You're in! Sit back and get ready for the show"
      end
    else
      redirect_to root_path, alert: "A show with the code #{params[:show_code]} wasn't found"
    end
  end

  private 

  def permitted_params
    params.require(:attendee).permit(:email, :name, :show_code)
  end
end
