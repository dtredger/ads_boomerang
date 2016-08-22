require 'rails_helper'

RSpec.describe "creative_line_item_assignments/index", type: :view do
  before(:each) do
    assign(:creative_line_item_assignments, [
      CreativeLineItemAssignment.create!(),
      CreativeLineItemAssignment.create!()
    ])
  end

  it "renders a list of creative_line_item_assignments" do
    render
  end
end
