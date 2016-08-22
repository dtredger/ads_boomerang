require 'rails_helper'

RSpec.describe "creative_line_item_assignments/edit", type: :view do
  before(:each) do
    @creative_line_item_assignment = assign(:creative_line_item_assignment, CreativeLineItemAssignment.create!())
  end

  it "renders the edit creative_line_item_assignment form" do
    render

    assert_select "form[action=?][method=?]", creative_line_item_assignment_path(@creative_line_item_assignment), "post" do
    end
  end
end
