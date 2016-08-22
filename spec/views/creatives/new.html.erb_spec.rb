require 'rails_helper'

RSpec.describe "creatives/new", type: :view do
  before(:each) do
    assign(:creative, Creative.new())
  end

  it "renders new creative form" do
    render

    assert_select "form[action=?][method=?]", creatives_path, "post" do
    end
  end
end
