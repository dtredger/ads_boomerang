class AddAdvertiserToCreatives < ActiveRecord::Migration[5.0]
  def change
    change_table :creatives do |t|
      t.belongs_to :advertiser, index: true
    end
  end
end
