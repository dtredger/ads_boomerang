class AddConfirmableToDevise < ActiveRecord::Migration[5.0]
	# Note: You can't use change, as Advertiser.update_all will fail in the down migration
	def up
		add_column :advertisers, :confirmation_token, :string
		add_column :advertisers, :confirmed_at, :datetime
		add_column :advertisers, :confirmation_sent_at, :datetime
		# add_column :advertisers, :unconfirmed_email, :string # Only if using reconfirmable
		add_index :advertisers, :confirmation_token, unique: true
		# Advertiser.reset_column_information # Need for some types of updates, but not for update_all.
		# To avoid a short time window between running the migration and updating all existing
		# advertisers as confirmed, do the following
		execute("UPDATE advertisers SET confirmed_at = NOW()")
		# All existing user accounts should be able to log in after this.
		# Remind: Rails using SQLite as default. And SQLite has no such function :NOW.
		# Use :date('now') instead of :NOW when using SQLite.
		# => execute("UPDATE advertisers SET confirmed_at = date('now')")
		# Or => Advertiser.all.update_all confirmed_at: Time.now
	end

	def down
		remove_columns :advertisers, :confirmation_token, :confirmed_at, :confirmation_sent_at
		# remove_columns :advertisers, :unconfirmed_email # Only if using reconfirmable
	end
end
