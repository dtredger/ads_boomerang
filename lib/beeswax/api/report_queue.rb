# http://docs.beeswax.com/docs/report_queue

#http://docs.beeswax.com/docs/reporting

# There are many types of reports to request
# ie.
#   1 - Performance Report
#   2 - Inventory Report
#   3 - Platform Report
#   4 - Mobile App Report
#   5 - Domain Report
#   6 - Conversion Report
#   7 - Vendor Report

class Beeswax::ReportQueue
  PATH = '/rest/report_queue'

  # @param report_id [:performance_report, :inventory_report, :platform_report, :mobile_app_report, :domain_report, :conversion_report, :vendor_report] Required. The report ID.
  # @param request_details [Hash] Set of attributes to filter by
  # @return [Hash] Payload portion of response containing :id
  def self.find(opts={})
    raise BeeswaxError, "#{self.to_s}.find -> :report_id required" unless opts[:report_id]
    raise BeeswaxError, "#{self.to_s}.find -> :request_details required" unless opts[:request_details]

    case opts[:report_id]
    when :performance_report then opts[:report_id] = 1
    when :inventory_report   then opts[:report_id] = 2
    when :platform_report    then opts[:report_id] = 3
    when :mobile_app_report  then opts[:report_id] = 4
    when :domain_report      then opts[:report_id] = 5
    when :conversion_report  then opts[:report_id] = 6
    when :vendor_report      then opts[:report_id] = 7
    else
      opts[:report_id] = 1 unless opts[:report_id].is_a?(Integer)
    end

    response = Beeswax.request(:post, PATH, opts)

    # Check if response includes rows
    rows, i = [[], 0]
    while response[:payload][:"#{i}"]
      row = response[:payload][:"#{i}"]
      # Clean up spaces in keys
      row = row.inject({}) do |memo,pair|
        key   = pair[0].to_s.split(' ').map(&:downcase).join('_').to_sym
        value = pair[1]
        memo[key] = value
        memo
      end
      rows << row
      i += 1
    end

    return rows.any? ? rows : response[:payload]
  end
end
