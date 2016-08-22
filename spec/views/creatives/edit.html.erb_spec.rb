require 'rails_helper'

RSpec.describe "creatives/edit", type: :view do
  before(:each) do
    @creative = assign(:creative, Creative.create!())
  end

  it "renders the edit creative form" do
    render

    assert_select "form[action=?][method=?]", creative_path(@creative), "post" do
    end
  end
end
