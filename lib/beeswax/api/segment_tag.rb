# Receive the tracking pixel for a previously created segment
# https://docs.api.beeswax.com/rest/segment_tag

class Beeswax::SegmentTag
  PATH = '/rest/segment_tag'

  # @param segment_id [Integer] Unique ID for the segment
  # @param segment_name [String] Name for the segment
  # @param advertiser_id [Integer] Unique ID for the advertiser
  # @param tag_type [String] `js`. The tag type to render, default is js for javascript tags.
  # @param format [String]	`none`. The format to return the tags, default is `none`. Optional values can include `csv`, `xml`, `xls`, `xlsx` and `json` If not set or set to none the tags will be returned in the standard API response. If set, a file with the content will be streamed to the output.
  # @return [Hash] Payload portion of response containing :tag
  def self.get(opts={})
    opts[:tag_type] = 'js' unless opts[:tag_type]
    response = Beeswax.request(:get, PATH, opts)
    return response[:payload]
  end
end
