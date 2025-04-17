class MakeVoteAttendeeIdOptional < ActiveRecord::Migration[8.0]
  def change
    change_column_null :votes, :attendee_id, true
  end
end
