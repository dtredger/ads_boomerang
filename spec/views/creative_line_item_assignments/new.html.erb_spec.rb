require 'rails_helper'

RSpec.describe "creative_line_item_assignments/new", type: :view do
  before(:each) do
    assign(:creative_line_item_assignment, CreativeLineItemAssignment.new())
  end

  it "renders new creative_line_item_assignment form" do
    render

    assert_select "form[action=?][method=?]", creative_line_item_assignments_path, "post" do
    end
  end
end
