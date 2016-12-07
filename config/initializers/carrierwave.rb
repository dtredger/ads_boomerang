# http://icebergist.com/posts/rspec-and-factorygirl-setup-for-testing-carrierwave-uploaders/
require 'carrierwave'

CarrierWave.configure do |config|
	config.storage = :fog
	config.fog_credentials = {
			provider: 'AWS',
			aws_access_key_id: ENV['AWS_S3_KEY'],
			aws_secret_access_key: ENV['AWS_S3_SECRET'],
			region: ENV['AWS_S3_BUCKET_REGION']
	}

	config.cache_dir        = "#{Rails.root}/tmp/uploads"
	config.fog_directory    = ENV['AWS_S3_BUCKET_NAME']
	# config.s3_access_policy = :public_read # Generate http:// urls (Defaults to :authenticated_read)
	# config.fog_host         = "#{ENV['S3_ASSET_URL']}/#{ENV['S3_BUCKET_NAME']}"
end


if Rails.env.test? || Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    # config.enable_processing = false
  end

  # make sure our uploader is auto-loaded
  CreativeAssetUploader

  # use different dirs when testing
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      end
    end
  end
end