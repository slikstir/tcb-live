class UpdateLiveStreamStateJob < ApplicationJob
  queue_as :default

  def perform(live_stream, new_state)
    return if live_stream.state == new_state

    live_stream.update!(state: new_state)
  end
end