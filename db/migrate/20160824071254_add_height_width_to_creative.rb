class AddHeightWidthToCreative < ActiveRecord::Migration[5.0]
  def change
    change_table :creatives do |t|
      t.integer "width"
      t.integer "height"
    end
  end
end
