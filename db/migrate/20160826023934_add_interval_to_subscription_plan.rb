class AddIntervalToSubscriptionPlan < ActiveRecord::Migration[5.0]
  def change
		change_table :subscription_plans do |t|
			t.string :interval, null: false
			t.string :stripe_id, null: false
			t.integer :amount, null: false
		end

		remove_column :subscription_plans, :price
		remove_column :subscription_plans, :permalink
  end
end
