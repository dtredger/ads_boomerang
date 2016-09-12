class AddSegmentsToCampaign < ActiveRecord::Migration[5.0]
  def change
		change_table :campaigns do |t|
			t.integer :include_segment_id
			t.integer :exclude_segment_id
		end
  end
end
