class UpdateLiveStreamPollStateJob < ApplicationJob
  queue_as :default

  def perform(live_stream_poll, new_state)
    return if live_stream_poll.state == new_state

    live_stream_poll.update!(state: new_state)
  end
end
