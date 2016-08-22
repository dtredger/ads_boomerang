require 'rails_helper'

RSpec.describe "advertisers/new", type: :view do
  before(:each) do
    assign(:advertiser, Advertiser.new())
  end

  it "renders new advertiser form" do
    render

    assert_select "form[action=?][method=?]", advertisers_path, "post" do
    end
  end
end
