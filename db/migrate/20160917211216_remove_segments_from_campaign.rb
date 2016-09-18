class RemoveSegmentsFromCampaign < ActiveRecord::Migration[5.0]
  def change
		remove_column :campaigns, :include_segment_id
		remove_column :campaigns, :exclude_segment_id
  end
end
