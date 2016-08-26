class RemoveSubscriptionPlans < ActiveRecord::Migration[5.0]
  def change
	  drop_table :subscription_plans
  end
end
