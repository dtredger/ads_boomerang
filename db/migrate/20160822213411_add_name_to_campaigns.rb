class AddNameToCampaigns < ActiveRecord::Migration[5.0]
  def change
    change_table :campaigns do |t|
      t.string :name, null: false
    end
  end
end
