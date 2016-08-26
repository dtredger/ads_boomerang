# https://docs.api.beeswax.com/rest/creative_template

# There are many creative templates already created that may be of use before
# needing to create your own. ie (at time of writing):
#   1 - Image template
#   2 - Flash template
#   3 - VAST InLine
#   4 - JS Tag
#   5 - iFrame Tag
#   6 - VAST and VPAID Wrapper
#   7 - VAST 2.0 Template, Static Companion
#   8 - VAST 2.0 Template, HTML Companion
#   9 - VPAID Inline
#   10 - VPAID, Static Companion
#   11 - VPAID, HTML Companion
#   ....

class Beeswax::CreativeTemplate
  PATH = '/rest/creative_template'

  # @param creative_template_name [String] Required. Name of the Creative Template, e.g. "JPEG Banner"
  # @param global [Boolean] Required. Default false. Is this a global rule, available to all Buzz accounts? Only Super Users may create global rules.
  # @param rendering_key [String] Required. The type of validation to use when creative_assets are added directly to a Creative. Currently supported keys include IMAGE, FLASH, VAST, and VPAID
  # @param creative_template_content [String] Required. The plain text payload of the template ad (HTML, XML, etc), including macros.
  # @param creative_attributes [Array] Array of objects. JSON list of attributes to be inherited by the Creative after applying this template.
  # @param notes [String] <255 chars
  # @param active [Boolean] Required. Is the Creative Template active?
  # @return [Hash] Payload portion of response containing :id
  def self.create(opts={})
    opts[:global] = false unless opts[:global] == true
    raise BeeswaxError, "#{self.to_s}.create -> :creative_template_name [String] required"  unless opts[:creative_template_name].is_a?(String)
    raise BeeswaxError, "#{self.to_s}.create -> :rendering_key [String] required"  unless opts[:rendering_key].is_a?(String)
    raise BeeswaxError, "#{self.to_s}.create -> :creative_template_content [String] required"  unless opts[:creative_template_content].is_a?(String)
    raise BeeswaxError, "#{self.to_s}.create -> :active required to be true or false" unless [true, false].include?(opts[:active])
    response = Beeswax.request(:post, PATH, opts)
    return response[:payload]
  end
end
