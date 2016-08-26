# https://docs.api.beeswax.com/rest/targeting_template

class Beeswax::TargetingTemplate
  PATH = "/rest/targeting_template"

  # @param template_name [String] Name of the template. <100 chars
  # @param alternative_id [String] Alternative ID
  # @param strategy_id [:banner, :video] Unique ID of the Strategy
  # @param targeting [Array] JSON representation of the targeting keys and values.
  # @param active [Boolean] Default is true
  # @return [Hash] Payload portion of response containing :id
  def self.create(opts={})
    opts[:active] = true unless opts[:active] # Defualt to active: true
    raise BeeswaxError, "#{self.to_s}.create -> :active requred to be true or false" unless [true, false].include?(opts[:active])

    case opts[:strategy_id]
    when :banner then opts[:strategy_id] = 1
    when :video then opts[:strategy_id] = 2
    else
      opts[:strategy_id] = 1 unless opts[:strategy_id].is_a?(Integer)
    end

    response = Beeswax.request(:post, PATH, opts)
    return response[:payload]
  end

  def self.update(opts={})
    raise BeeswaxError, "#{self.to_s}.create -> :targeting_template_id required" unless opts[:targeting_template_id]
    response = Beeswax.request(:put, PATH, opts)
    return response[:payload]
  end
end
