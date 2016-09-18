class RenameTypeColumn < ActiveRecord::Migration[5.0]
  def change
		remove_column :segments, :type
		add_column :segments, :audience, :integer
  end
end
