class CreateWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :websites do |t|
			t.string :name
			t.string :domain_name

			t.integer :provider
			t.json :pages

      t.timestamps
    end

    add_column :campaigns, :website_id, :integer
  end
end
