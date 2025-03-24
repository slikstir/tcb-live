module Admin
  class AdminController < ApplicationController
    layout 'admin'

    before_action :authenticate_user!

    def index
      
    end

    private

  end
end
