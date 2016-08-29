# == Schema Information
#
# Table name: subscription_plans
#
#  id         :integer          not null, primary key
#  amount     :integer
#  interval   :string
#  stripe_id  :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :subscription_plan do
    amount 1
    interval "MyString"
    stripe_id "MyString"
    name "MyString"
  end
end
