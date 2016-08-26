# https://docs.api.beeswax.com/rest/campaign

class Beeswax::Campaign
  PATH = '/rest/campaign'

  # @param advertiser_id [Integer] Required. Must belong to the same account as the Campaign and be active
  # @param alternative_id [String] An alternative id to lookup the Campaign, if desired
  # @param campaign_name [String] Required. Name of the Campaign, e.g. "Winter lead generation"
  # @param campaign_budget [Float] Required. Maximum amount to spend on this Campaign
  # @param daily_budget [Float] Maximum amount to spend or deliver in a day, Cannot exceed campaign_budget or be so low as to prevent campaign_budget from being reached over the length of the campaign. Cannot be lower than the daily_budget for any Line Items associated with this campaign.
  # @param budget_type [:spend, :impressions] Required. Default :spend Type of budget, 0=spend, 1=impressions
  # @param revenue_type [String] Must be a valid type as defined in the `revenue_types` view. Currently only `CPM` and `CPC` are supported.
  # @param revenue_amount [Float] If a revenue_type is set, this is field is the basis of calculation. For example, if revenue_type is CPM and revenue_amount is 5.12, revenue will be calculated as a $5.12 CPM.
  # @param pacing [:no_pacing, :pace_evenly] Default :no_pacing. How to pace the delivery of this Campaign. 0=no pacing, 1=pace evenly. Pacing may only be set (1) if the Campaign has a non-blank end_date.
  # @param start_date [DateTime] Required. Start date of the Campaign. No Line Items associated with the Campaign can have start dates prior to this date.
  # @param end_date [DateTime] End date of the Campaign. No Line Items associated with the Campaign can have end dates after this date. End date must be provided in order to pace.
  # @param frequency_cap [Array] Frequency cap JSON. For more information on frequency caps, see Frequency Caps.
  # @param notes [String] Notes, up to 255 chars
  # @param active [Boolean] Required. Is it active?
  # @return [Hash] Payload portion of response containing :id
  def self.create(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :advertiser_id required" unless opts[:advertiser_id]
    raise BeeswaxError, "#{self.to_s}.create -> :campaign_name required" unless opts[:campaign_name]
    raise BeeswaxError, "#{self.to_s}.create -> :campaign_budget required to be a Float" unless opts[:campaign_budget].is_a?(Float)
    raise BeeswaxError, "#{self.to_s}.create -> :start_date required" unless opts[:start_date].is_a?(Time)
    raise BeeswaxError, "#{self.to_s}.create -> :active must be true or false" unless [true, false].include?(opts[:active])
    unless opts[:revenue_type].nil? || %w(CPM CPC).include?(opts[:revenue_type])
      raise BeeswaxError, "#{self.to_s}.create -> :revenue_type must be 'CPM' or 'CPC' if specified"
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
    raise BeeswaxError, "#{self.to_s}.create -> :campaign_id required" unless opts[:campaign_id]
    response = Beeswax.request(:put, PATH, opts)
    return response[:payload]
  end

  # @return [Hash] Payload portion of response containing :id, :success, :message
  def self.delete(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :campaign_id required" unless opts[:campaign_id]
    response = Beeswax.request(:delete, PATH, opts)
    return response[:payload]
  end

end
