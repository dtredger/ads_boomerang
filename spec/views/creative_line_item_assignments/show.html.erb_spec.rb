require 'rails_helper'

RSpec.describe "creative_line_item_assignments/show", type: :view do
  before(:each) do
    @creative_line_item_assignment = assign(:creative_line_item_assignment, CreativeLineItemAssignment.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
