# https://docs.api.beeswax.com/rest/creative

class Beeswax::Creative
  PATH = '/rest/creative'

	# @param creative_id [Integer] Required. Must belong to the same account as the Advertiser and be active
  def self.get(creative_id)
	  raise BeeswaxError, "#{self.to_s}.get -> :creative_id required" unless creative_id.is_a?(Integer)
	  response = Beeswax.request(:get, "#{PATH}/#{creative_id}")
	  return response[:payload][0]
  end

  # @param advertiser_id [Integer] Required. Must belong to the same account as the Advertiser and be active
  # @param alternative_id [String] An alternative id to lookup the Creative, if desired
  # @param creative_name [String] Required. Name of the Creative, e.g. "Blue Banner Ad"
  # @param creative_type [:banner, :video] Required. Default :banner. The type of creative. 0=banner, 1=video
  # @param width [Integer] Width in pixels. Use the creative_sizes view to see all acceptable width and height combinations.
  # @param height [Integer] Height in pixels. Use the creative_sizes view to see all acceptable width and height combinations.
  # @param sizeless [Boolean] Required. Default false. Is the creative sizeless, meaning it can match any size placement that is an interstitial.
  # @param secure [Boolean] Required. Default false. Is the creative intended to serve in a secure (HTTPS) environment.
  # @param click_url [String] URL the ad should click or tap to, must be a valid URL. This field is required when using a Creative Template that is not a tag (e.g. an image or video)
  # @param creative_assets [Array] Array of integers. A list of Creative Assets to be used to render the creative. Typically a single ID for an image or video.
  # @param creative_content [Array] A JSON representation of the fields required by the Creative Template, validated against the Creative Template
  # @param creative_template_id [Integer] Required. The ID of the Creative Template to use for this creative. Must be a valid and active Creative Template that either belongs to this Account, OR is marked as "global".
  # @param creative_rule_id [Integer] The ID of a Creative Rule to be applied to the content of this Creative. Note, the rule is deployed once on the creative, and if successful, is not saved in the creative. Must be a valid and active Creative Rule that either belongs to this Account, OR is marked as "global".
  # @param creative_attributes [Array]	Array of objects. Creative Attributes JSON.
  # @param creative_thumbnail_url [String] URL to an image thumbnail for the creative. This field will be automatically set if you associate the creative with a Creative Asset that has a valid thumbnail but must be updated manually when using a tag-based Creative. Thumbnail is required by some exchanges to serve.
  # @param notes [String] Notes about the Creative, up to 255 chars
  # @param active [Boolean] Required. Is the Creative active?
  # @return [Hash] Payload portion of response containing :id
  def self.create(opts={})
    opts[:sizeless] = false unless opts[:sizeless] == true
    opts[:secure] = false unless opts[:secure] == true

    raise BeeswaxError, "#{self.to_s}.create -> :advertiser_id required" unless opts[:advertiser_id]
    raise BeeswaxError, "#{self.to_s}.create -> :creative_name required" unless opts[:creative_name].is_a?(String)
    raise BeeswaxError, "#{self.to_s}.create -> :creative_template_id [Integer] required" unless opts[:creative_template_id].is_a?(Integer)
    raise BeeswaxError, "#{self.to_s}.create -> :active required to be true or false" unless [true, false].include?(opts[:active])

    case opts[:creative_type]
    when :banner then opts[:creative_type] = 0
    when :video then opts[:creative_type] = 1
    else
      opts[:creative_type] = 0 unless opts[:creative_type].is_a?(Integer)
    end

    response = Beeswax.request(:post, PATH, opts)
    return response[:payload]
  end

  def self.update(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :creative_id required" unless opts[:creative_id]
    response = Beeswax.request(:put, PATH, opts)
    return response[:payload]
  end

  def self.delete(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :creative_id required" unless opts[:creative_id]
    response = Beeswax.request(:delete, PATH, opts)
    return response[:payload]
  end
end
