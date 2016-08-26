# https://docs.api.beeswax.com/rest/creative_asset

# Step 1: #create the object
# Step 2: #uplaod the file for the object

class Beeswax::CreativeAsset
  PATH = '/rest/creative_asset'
  # @param advertiser_id [Integer] Required. Advertiser that owns the asset
  # @param creative_asset_name [String] Required. Name of the Creative Asset, e.g. "Blue Banner Ad"
  # @param size_in_bytes [Integer] Required. Default 0. Number of bytes
  # @param notes [String] Notes about the Creative Asset, up to 255 chars
  # @param active [Boolean] Required. Is it active?
  # @return [Hash] Payload portion of response containing :id
  def self.create(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :advertiser_id required" unless opts[:advertiser_id]
    raise BeeswaxError, "#{self.to_s}.create -> :creative_asset_name [String] required" unless opts[:creative_asset_name].is_a?(String)
    raise BeeswaxError, "#{self.to_s}.create -> :size_in_bytes [Integer] required" unless opts[:size_in_bytes].is_a?(Integer)
    raise BeeswaxError, "#{self.to_s}.create -> :active required to be true or false" unless [true, false].include?(opts[:active])
    response = Beeswax.request(:post, PATH, opts)
    return response[:payload]
  end

  # @param creative_asset_id
  # @param creative_content [Binary]
  # @return [Hash] Payload portion of response containing :id
  def self.upload(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :creative_asset_id required" unless opts[:creative_asset_id]
    raise BeeswaxError, "#{self.to_s}.create -> :creative_content required" unless opts[:creative_content]
    creative_asset_id = opts.delete(:creative_asset_id)
    body              = opts.delete(:creative_content)

    endpoint = [PATH, 'upload', creative_asset_id].join('/')
    opts[:file] = body
    # opts[:content_type] = 'application/x-www-form-urlencoded'

    response = Beeswax.multipart_request(:post, endpoint, opts)
    return response[:payload]
  end
end
