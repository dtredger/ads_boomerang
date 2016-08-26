# https://docs.api.beeswax.com/rest/segment_category

class Beeswax::SegmentCategory
  PATH = "/rest/segment_category"

  # @param segment_category_name [String] Required. Name of the Segment Category. <191 chars
  # @param alternative_id [String] Any text up to 80 characters to identify the category
  # @param parent_category_key [String] Must be an active Segment Category. If omitted or set to NULL, this category will live at the top of the hierarchy.
  # @param advertiser_id [Integer] Segment Categories may belong to the overall Account or to a single Advertiser.
  # @return [Hash] Payload portion of response containing :id
  def self.create(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :segment_category_name required" unless opts[:segment_category_name].is_a?(String)

    response = Beeswax.request(:post, PATH, opts)
    return response[:payload]
  end
end
