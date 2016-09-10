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

  def self.get(opts={})
		response = Beeswax.request(:get, PATH, opts)
		return response[:payload]
  end

	# {
	# 		"segment_id": 266,
	# 		"segment_name": "VisualPing - default segment",
	# 		"segment_description": "Default segment for VisualPing site visitors",
	# 		"active": true,
	# 		"alternative_id": "vp-default",
	# 		"account_id": 75,
	# 		"segment_count": 30363,
	# 		"update_date": "2016-06-08 18:23:00",
	# 		"create_date": "2016-06-08 17:08:50",
	# 		"count_update_date": "2016-09-08 18:09:41",
	# 		"advertiser_id": 440,
	# 		"buzz_key": "stinger"
	# }
end

