class AdvertiserHasSubscriptionPlan < ActiveRecord::Migration[5.0]
  def change
		change_table :advertisers do |t|
			t.integer :subscription_plan_id
		end
  end
end
