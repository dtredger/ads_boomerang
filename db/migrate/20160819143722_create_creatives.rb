class CreateCreatives < ActiveRecord::Migration[5.0]
  def change
    create_table :creatives do |t|

      t.timestamps
    end
  end
end
