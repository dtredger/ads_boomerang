require 'rails_helper'
require 'beeswax/base'

RSpec.describe Beeswax do
	describe "module methods" do
		it { expect(subject).to respond_to :api_host }
		it { expect(subject).to respond_to :api_host= }
		it { expect(subject).to respond_to :api_password }
		it { expect(subject).to respond_to :api_password= }
		it { expect(subject).to respond_to :api_user }
		it { expect(subject).to respond_to :api_user= }
		it { expect(subject).to respond_to :authenticate }
		it { expect(subject).to respond_to :authentication_cookie }
		it { expect(subject).to respond_to :authentication_cookie= }
		it { expect(subject).to respond_to :environment }
		it { expect(subject).to respond_to :environment= }
		it { expect(subject).to respond_to :host }
		it { expect(subject).to respond_to :multipart_request }
		it { expect(subject).to respond_to :request }
	end

	# before { stub_request(:any, "www.example.com").to_return(status: [500, "Internal Server Error"]) }

end
