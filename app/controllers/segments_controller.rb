class SegmentsController < ApplicationController #ActionController::Base
	skip_before_action :verify_authenticity_token, only: :tag

	before_action :allow_any_origin

	caches_action :tag, :if => Proc.new { |c| ENV["CACHE_TAGS"] == 'true' },
	              :cache_path => Proc.new { |c| c.request.url },
	              :expire_in => 1.hour

	def tag
		find_website
		if @website && params[:s]
			respond_to do |format|
				format.html { head 204 }
				format.js { render "segments/segment" }
			end
		else
			head 204
		end
	end


	private

		def segment_params
			params.permit(:id, :s, :format)
		end

		def find_website
			params = segment_params
			@website = Website.find_by(id: params[:id])
			return unless @website && params[:s]
			@segment_tag = @website.get_segment(params[:s])
		end

		def allow_any_origin
			headers["Access-Control-Allow-Origin"] = "*"
		end

end