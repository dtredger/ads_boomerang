# == Schema Information
#
# Table name: line_items
#
#  id                    :integer          not null, primary key
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  inventory_source      :integer          not null
#  campaign_id           :integer          not null
#  name                  :string
#  beeswax_id            :integer
#  alternative_id        :string
#  line_item_type_id     :integer
#  targeting_template_id :integer
#  line_item_budget      :float
#  daily_budget          :float
#  budget_type           :integer
#  notes                 :string
#  active                :boolean
#

FactoryGirl.define do
  factory :line_item do
	  sequence(:name ) { |x| "test_line_item#{x}" }
	  inventory_source :adx

	  campaign

	  factory :beeswax_line_item do
		  beeswax_id 14695
	  end
  end
end
