class AddPermalinkBackToSubscription < ActiveRecord::Migration[5.0]
  def change
	  change_table :subscription_plans do |t|
		  t.string :permalink
	  end
  end
end
