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

require 'rails_helper'

RSpec.describe SubscriptionPlan, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
