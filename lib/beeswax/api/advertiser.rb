# https://docs.api.beeswax.com/rest/advertiser

class Beeswax::Advertiser
  PATH = '/rest/advertiser'

  # .get(###) = [{
		#    :advertiser_id=>38526,
		#    :advertiser_name=>"advertiser1@email.com",
		#    :default_click_url=>"http://email.com",
		#    :default_targeting=>[],
		#    :conversion_method_id=>1,
		#    :attributes=>{
		# 		   :advertiser=>{
		# 				   :advertiser_domain=>["http://www.adlinks.co"],
		# 				   :advertiser_category=>["IAB24"]
		# 		   }
		#    },
		#    :account_id=>94,
		#    :create_date=>"2016-09-05 22:45:11",
		#    :update_date=>"2016-09-19 15:52:25",
		#    :alternative_id=>"email.com",
		#    :notes=>"sdf 3",
		#    :active=>true,
		#    :buzz_key=>"stingersbx"
  #  }]

  def self.get(advertiser_id)
	  raise BeeswaxError, "#{self.to_s}.get -> :advertiser_id required" unless opts[:advertiser_id].is_a?(Integer)
		response = Beeswax.request(:get, "#{PATH}/#{advertiser_id}")
		return response[:payload]
  end

  # @param alternative_id [String] An alternative id to associate, if desired
  # @param advertiser_name [String] Required. Unique name for the advertiser, must be unique per account.
  # @param attributes [Array] Creative attributes in JSON.
  # @param conversion_method_id [Integer] Required but Default used. The conversion attribution to use for Events owned by this Advertiser. Must be a valid attribution method as found in the conversion_attribution_methods view. At this time only method 1 (last click) is supported. Once a conversion method is chosen, it cannot be changed.
  # @param default_click_url [String] Click URL to use by default for objects created under this advertiser
  # @param notes [String] Any notes desired, less than 255 chars
  # @return [Hash] Payload portion of response containing :id
  def self.create(opts={})
    opts[:conversion_method_id] = 1 unless opts[:conversion_method_id]
    raise BeeswaxError, "#{self.to_s}.create -> :advertiser_name required" unless opts[:advertiser_name].is_a?(String)
    response = Beeswax.request(:post, PATH, opts)
    return response[:payload]
  end

  # @return [Hash] Payload portion of response containing :id, :success, :message
  def self.update(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :advertiser_id required" unless opts[:advertiser_id]
    response = Beeswax.request(:put, PATH, opts)
    return response[:payload]
  end

  # @return [Hash] Payload portion of response containing :id, :success, :message
  def self.delete(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :advertiser_id required" unless opts[:advertiser_id]
    response = Beeswax.request(:delete, PATH, opts)
    return response[:payload]
  end

end

