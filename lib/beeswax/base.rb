BeeswaxError = Class.new(StandardError)

module Beeswax
  LIVE_HOST    = 'https://stinger.api.beeswax.com'
  SANDBOX_HOST = 'https://stingersbx.api.beeswax.com'

  ApiCredentialsNotSet = Class.new(StandardError)
  MethodNotSupported   = Class.new(StandardError)

  class << self
    attr_accessor :api_user, :api_password, :api_host,
                  :authentication_cookie, :environment
    attr_writer   :environment

    def environment
      @environment.to_sym == :live ? :live : :sandbox
    end

    def host
      environment == :live ? LIVE_HOST : SANDBOX_HOST
    end

    def authenticate
      raise ApiCredentialsNotSet unless api_user && api_password
      path = '/rest/authenticate'
      url = (api_host || host) + path

      options = {}
      options[:format] = :json
      options[:debug_output] = $stdout if ENV['DEBUG'] == 'true'

      options[:body] = {
        email: api_user,
        password: api_password
      }.to_json

      response = HTTParty.post(url, options)
      data = deep_symbolize_keys(response.parsed_response)

      unless data[:success] == true
        raise BeeswaxError, [data[:message], data[:errors]].join(' ')
      end

      self.authentication_cookie = HTTParty::CookieHash.new
      # We get some 'path=/,' text that messes with adding all the cookies that
      # we'll strip out here for the time being
      self.authentication_cookie.add_cookies(
        response.headers['set-cookie'].split('path=/, ').join
      )
      return true
    end

    def request(method, path, args={})
      raise ApiCredentialsNotSet unless api_user && api_password
      raise MethodNotSupported unless %w(get post put delete).include?(method.to_s)

      url = (api_host || host) + path

      options = {}
      request_format = args.delete(:format)
      options[:format] = request_format || :json
      options[:debug_output] = $stdout if ENV['DEBUG'] == 'true'

      if authentication_cookie
        options[:headers] = {'Cookie' => authentication_cookie.to_cookie_string}
      else
        raise BeeswaxError, 'Not Authenticated. Please use Beeswax.authenticate to set cookie first'
      end

      content_type = args.delete(:content_type)
      options[:headers]['Content-Type'] = content_type if content_type

      if args[:body]
        options[:body] = args[:body] # Useful for file upload
      else
        options[:body] = args.to_json
      end

      response = HTTParty.send(method, url, options)

      data = deep_symbolize_keys(response.parsed_response)

      unless data[:success] == true
        raise BeeswaxError, [data[:message], data[:errors]].join(' ')
      end

      return data
    end

    # For File Uploads, multipart required
    def multipart_request(method, path, args={})
      raise ApiCredentialsNotSet unless api_user && api_password
      raise MethodNotSupported unless %w(get post put delete).include?(method.to_s)

      url = (api_host || host) + path

      options = {}
      request_format = args.delete(:format)
      options[:format] = request_format || :json
      options[:debug_output] = $stdout if ENV['DEBUG'] == 'true'

      unless authentication_cookie
        raise BeeswaxError, 'Not Authenticated. Please use Beeswax.authenticate to set cookie first'
      end

      response = HTTMultiParty.send(method, url, {
        headers: {'Cookie' => authentication_cookie.to_cookie_string},
        query: {
          creative_content: args[:file]
        },
        detect_mime_type: true
      })

      data = deep_symbolize_keys(response.parsed_response)

      unless data[:success] == true
        raise BeeswaxError, [data[:message], data[:errors]].join(' ')
      end

      return data
    end

    private

    # Essentially as implemented in ActiveSupport
    def deep_symbolize_keys(object)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), result|
          result[key.to_sym] = deep_symbolize_keys(value)
        end
      when Array
        object.map {|e| deep_symbolize_keys(e) }
      else
        object
      end
    end
  end
end

require "beeswax/api/advertiser"
require "beeswax/api/campaign"
require "beeswax/api/creative"
require "beeswax/api/creative_asset"
require "beeswax/api/creative_line_item"
require "beeswax/api/creative_template"
require "beeswax/api/line_item"
require "beeswax/api/report_queue"
require "beeswax/api/segment"
require "beeswax/api/segment_category"
require "beeswax/api/segment_tag"
require "beeswax/api/targeting_template"
require "beeswax/api/view"
require "beeswax/constants/geo"
require "httparty"
require "httmultiparty"