class AddNotesToWebsite < ActiveRecord::Migration[5.0]
  def change
		add_column :websites, :hosting_provider, :integer
		add_column :websites, :notes, :string
  end
end
