class CreateSegments < ActiveRecord::Migration[5.0]
  def change
    create_table :segments do |t|
      t.integer :type
      t.integer :beeswax_id
      t.string :segment_name
      t.boolean :active
      t.string :alternative_id
      t.integer :campaign_id
      t.integer :segment_count

      t.timestamps
    end
  end
end
