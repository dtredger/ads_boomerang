class AddDatesToCampaign < ActiveRecord::Migration[5.0]
  def change
		change_table :campaigns do |t|
			t.datetime :start_date
			t.datetime :end_date
		end
  end
end
