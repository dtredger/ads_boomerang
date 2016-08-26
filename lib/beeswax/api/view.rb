# http://docs.beeswax.com/docs/view

class Beeswax::View
  PATH = '/rest/view'

  def self.find(opts={})
    # opts[:view_name] = 'reports'
    # raise BeeswaxError, "#{self.to_s}.create -> :advertiser_id required" unless opts[:advertiser_id]
    response = Beeswax.request(:get, PATH, opts)
    return response[:payload]
  end
end
