class AddPriceBackToSubscription < ActiveRecord::Migration[5.0]
  def change
		change_table :subscription_plans do |t|
			t.integer :price
		end
  end
end
