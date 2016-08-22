require 'rails_helper'

RSpec.describe "creatives/show", type: :view do
  before(:each) do
    @creative = assign(:creative, Creative.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
