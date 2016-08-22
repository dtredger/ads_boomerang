class AddAdvertiserToCampaigns < ActiveRecord::Migration[5.0]
  def change
    change_table :campaigns do |t|
      t.belongs_to :advertiser, index: true
    end
  end
end
