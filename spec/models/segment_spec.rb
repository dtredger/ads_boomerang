# == Schema Information
#
# Table name: segments
#
#  id             :integer          not null, primary key
#  beeswax_id     :integer
#  segment_name   :string
#  active         :boolean
#  alternative_id :string
#  campaign_id    :integer
#  segment_count  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  audience       :integer
#

require 'rails_helper'

RSpec.describe Segment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
