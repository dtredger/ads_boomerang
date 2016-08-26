# https://docs.api.beeswax.com/rest/creative_line_item

class Beeswax::CreativeLineItem
  PATH = '/rest/creative_line_item'

  # @param creative_id [Integer] Required. Unique ID of the Creative to be associated. Must be active and be the same type as the Line Item.
  # @param line_item_id [Integer] Required. Unique ID of the Line Item to be associated. Must be active and be the same type as the Creative
  # @param weighting [Integer] Not currently used
  # @param active [Boolean] Required. Is it active?
  # @return [Hash] Payload portion of response containing :id
  def self.create(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :creative_id required" unless opts[:creative_id]
    raise BeeswaxError, "#{self.to_s}.create -> :line_item_id required" unless opts[:line_item_id]
    raise BeeswaxError, "#{self.to_s}.create -> :active required to be true or false" unless [true, false].include?(opts[:active])
    response = Beeswax.request(:post, PATH, opts)
    return response[:payload]
  end
end
