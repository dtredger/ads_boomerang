class AddNameToCreatives < ActiveRecord::Migration[5.0]
  def change
    change_table :creatives do |t|
      t.string :name, null: false
    end
  end
end
