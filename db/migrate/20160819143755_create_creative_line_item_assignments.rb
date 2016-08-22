class CreateCreativeLineItemAssignments < ActiveRecord::Migration[5.0]
  def change
    create_table :creative_line_item_assignments do |t|

      t.timestamps
    end
  end
end
