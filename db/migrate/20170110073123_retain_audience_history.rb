class RetainAudienceHistory < ActiveRecord::Migration[5.0]
  def change
	  rename_column :segments, :audience, :audience_type
	  remove_column :segments, :audience_count

		add_column :segments, :audience_history, :json
  end
end
