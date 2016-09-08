class AddOpenrtbFieldsToLineitem < ActiveRecord::Migration[5.0]
  def change
		change_table :line_items do |t|
			t.string :name
			t.integer :beeswax_id
			t.string :alternative_id
			t.integer :line_item_type_id
			t.integer :targeting_template_id
			t.float :line_item_budget
			t.float :daily_budget
			t.integer :budget_type
			t.string :notes
			t.boolean :active
		end
  end
end
