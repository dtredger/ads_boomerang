require 'rails_helper'

RSpec.describe "advertisers/show", type: :view do
  before(:each) do
    @advertiser = assign(:advertiser, Advertiser.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
