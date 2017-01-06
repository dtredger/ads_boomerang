class RenameSegmentCountToAudienceSize < ActiveRecord::Migration[5.0]
  def change
	  remove_column :segments, :segment_count
	  add_column :segments, :audience_count, :integer
  end
end
