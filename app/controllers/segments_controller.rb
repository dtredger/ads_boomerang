class SegmentsController < ApplicationController #ActionController::Base
	skip_before_action :verify_authenticity_token, only: :tag
	before_action :allow_any_origin
	before_action :find_website

	def tag
		if @website
			respond_to do |format|
				format.html { head 204 }
				format.js { render "segments/segment" }
			end
		else
			head 204
		end
	end


	private

		def find_website
			referrer = URI.parse(segment_params[:d])
			@website = Website.find_by(domain_name: referrer.host)
			return unless @website

			if @website.pages.exclude?(referrer)
				@website.pages.push(referrer)
			end
			# TODO - decisioning wrt include vs exclude segments, conversion tags
			if @website.campaign && @website.campaign.include_segment
				@segment_tag = @website.campaign.include_segment.retarget_src
			end
		end

		def segment_params
			params.permit(:d)
		end

		def allow_any_origin
			headers["Access-Control-Allow-Origin"] = "*"
		end

end