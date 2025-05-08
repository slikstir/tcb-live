module Admin
  class LiveStreamsController < AdminController
    before_action :find_records
    def show
    end

    def new
    end

    def create
      @live_stream = LiveStream.new(live_stream_params)
      if @live_stream.save
        redirect_to admin_show_live_stream_path(@show, @live_stream), notice: "Live stream was successfully created."
      else
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace(@live_stream, partial: "admin/live_streams/form", locals: { live_stream: @live_stream }) }
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      if @live_stream.update(live_stream_params)
        redirect_to admin_show_live_stream_path(@show, @live_stream), notice: "Live stream was successfully updated."
      else
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace(@live_stream, partial: "admin/live_streams/form", locals: { live_stream: @live_stream }) }
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @live_stream.destroy
      redirect_to admin_show_path(@show), notice: "Live stream was successfully destroyed."
    end

    private

    def live_stream_params
      params.require(:live_stream).permit(
          :name, :description, :stream_delay, :show_id, :code,
          live_stream_polls_attributes: [ :id, :poll_id, :stream_delay, :count_votes ]
      )
    end

    def find_records
      @show = Show.find(params[:show_id])
      params[:id] ? @live_stream = LiveStream.find(params[:id]) : @live_stream = LiveStream.new(show: @show)
    end
  end
end
