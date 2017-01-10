class AddManualSrcToSegments < ActiveRecord::Migration[5.0]
  def change
		add_column :segments, :manual_image_src, :string
  end
end
