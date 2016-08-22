require 'rails_helper'

RSpec.describe "creatives/index", type: :view do
  before(:each) do
    assign(:creatives, [
      Creative.create!(),
      Creative.create!()
    ])
  end

  it "renders a list of creatives" do
    render
  end
end
