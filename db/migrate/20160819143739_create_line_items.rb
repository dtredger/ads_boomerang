class CreateLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :line_items do |t|

      t.timestamps
    end
  end
end
