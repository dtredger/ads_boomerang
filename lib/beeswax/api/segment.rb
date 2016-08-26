# https://docs.api.beeswax.com/rest/segment

class Beeswax::Segment
  PATH = '/rest/segment'

  # @param segment_name [String] Name of the Segment. <191 chars
  # @param alternative_id [String] Unlike other objects, the `alternative_id` for segments must be unique per account. This enables the use of the `alternative_id` as a segment identifier when using the `segment_upload` method by setting the `segment_key_type` field.
  # @param advertiser_id [Integer] Segments may belong to the overall Account or to a single Advertiser.
  # @param segment_description [String] Longer description of the segment
  # @param cpm_cost [Float] Cost to track for the segment
  # @return [Hash] Payload portion of response containing :id
  def self.create(opts={})
    response = Beeswax.request(:post, PATH, opts)
    return response[:payload]
  end
end
