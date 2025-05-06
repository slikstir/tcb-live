module Admin
  class SettingsController < AdminController
    before_action :set_setting, only: [ :show, :edit, :update, :destroy ]

    def index
      @settings = Setting.all
    end

    def show
    end

    def new
      @setting = Setting.new
    end

    def edit
    end

    def create
      @setting = Setting.new(setting_params)

      if @setting.save
        redirect_to admin_path, notice: "Setting was successfully created."
      else
        render :new
      end
    end

    def update
      if @setting.update(setting_params)
        redirect_to admin_path, notice: "Setting was successfully updated."
      else
        render :edit
      end
    end

    def destroy
      @setting.destroy
      redirect_to admin_settings_url, notice: "Setting was successfully destroyed."
    end

    private
      def set_setting
        @setting = Setting.find(params[:id])
      end

      def setting_params
        params.require(:setting).permit(
          :name,
          :code,
          :value_type,
          :value,
          :image,
          :html
        )
      end

      def broadcast_activity(activity)
        nil unless activity
      end
  end
end
