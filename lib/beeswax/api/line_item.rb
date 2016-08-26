# https://docs.api.beeswax.com/rest/line_item

class Beeswax::LineItem
  PATH = '/rest/line_item'


  # @param campaign_id [Integer] Must be a valid and active Campaign
  # @param advertiser_id [Integer] Required. Must be active
  # @param alternative_id [String] An alternative id to lookup the Line Item, if desired
  # @param line_item_type_id [:banner, :video] Required. The type of the Line Item. 0=banner, 1=video.
  # @param targeting_template_id [Integer] The ID of the associated Targeting Template, must be a valid and active Targeting Template.
  # @param line_item_name [String] Required. Name of the Line Item, e.g. "Winter lead generation"
  # @param line_item_budget [Float] Required. Maximum amount to spend on this Line Item
  # @param daily_budget [Float] Maximum amount to spend or deliver in a day, cannot exceed campaign_budget or be so low as to prevent campaign_budget from being reached over the length of the campaign.
  # @param budget_type [:spend, :impressions] Required. Type of budget, 0=spend, 1=impressions
  # @param revenue_type [String] Must be a valid `revenue_type` as defined in the `revenue_types` view. Currently only `CPM` and `CPC` are supported.
  # @param revenue_amount [Float] If a `revenue_type` is set, this is field is the basis of calculation. For example, if revenue_type is CPM and revenue_amount is 5.12, revenue will be calculated as a $5.12 CPM.
  # @param pacing [:no_pacing, :pace_evenly] How to pace the delivery of this Line Item. 0=no pacing, 1=pace evenly. Pacing may only be set (1) if the Campaign has a non-blank end_date.
  # @param bidding [Hash] Required. Bidding Strategy JSON.
  # @param start_date [DateTime] Required. Start date of the Line Item.
  # @param end_date [DateTime] End date of the Line Item.
  # @param frequency_cap [Array] Frequency cap JSON.
  # @param notes [String] Notes about the Line Item, up to 255 chars
  # @param active [Boolean] Required. Is the Line Item active? Must be set to 0 on POST since no Creatives are yet assigned.
  # @return [Hash] Payload portion of response containing :id
  def self.create(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :advertiser_id required" unless opts[:advertiser_id]
    raise BeeswaxError, "#{self.to_s}.create -> :line_item_name required" unless opts[:line_item_name].is_a?(String)
    raise BeeswaxError, "#{self.to_s}.create -> :line_item_budget required to be a Float" unless opts[:line_item_budget].is_a?(Float)
    raise BeeswaxError, "#{self.to_s}.create -> :start_date required" unless opts[:start_date].is_a?(Time)
    raise BeeswaxError, "#{self.to_s}.create -> :active can not be true on create. No Creative paired yet." unless opts[:active] === false
    raise BeeswaxError, "#{self.to_s}.create -> :bidding object required ie. {'bidding_strategy': 'cpm', 'values': {'cpm_bid': 1.12} }" unless opts[:bidding].is_a?(Hash)
    unless opts[:revenue_type].nil? || %w(CPM CPC).include?(opts[:revenue_type])
      raise BeeswaxError, "#{self.to_s}.create -> :revenue_type must be 'CPM' or 'CPC' if specified"
    end

    case opts[:line_item_type_id]
    when :banner then opts[:line_item_type_id] = 0
    when :video then opts[:line_item_type_id] = 1
    else
      opts[:line_item_type_id] = 0 unless opts[:line_item_type_id].is_a?(Integer)
    end

    case opts[:budget_type]
    when :spend then opts[:budget_type] = 0
    when :impressions then opts[:budget_type] = 1
    else
      opts[:budget_type] = 0 unless opts[:budget_type].is_a?(Integer)
    end

    case opts[:pacing]
    when :no_pacing then opts[:pacing] = 0
    when :pace_evenly then opts[:pacing] = 1
    else
      opts[:pacing] = 0 unless opts[:pacing].is_a?(Integer)
    end

    response = Beeswax.request(:post, PATH, opts)
    return response[:payload]
  end

  # @return [Hash] Payload portion of response containing :id, :success, :message
  def self.update(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :line_item_id required" unless opts[:line_item_id]
    response = Beeswax.request(:put, PATH, opts)
    return response[:payload]
  end

  # @return [Hash] Payload portion of response containing :id, :success, :message
  def self.delete(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :line_item_id required" unless opts[:line_item_id]
    response = Beeswax.request(:delete, PATH, opts)
    return response[:payload]
  end
end
