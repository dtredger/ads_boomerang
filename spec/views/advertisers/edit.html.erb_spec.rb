require 'rails_helper'

RSpec.describe "advertisers/edit", type: :view do
  before(:each) do
    @advertiser = assign(:advertiser, Advertiser.create!())
  end

  it "renders the edit advertiser form" do
    render

    assert_select "form[action=?][method=?]", advertiser_path(@advertiser), "post" do
    end
  end
end
