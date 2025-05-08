class MakeVotesEligibleOrNot < ActiveRecord::Migration[8.0]
  def change
    change_table :votes do |t| 
      t.boolean :eligible, default: true
    end
  end
end
