class SegmentsController < ApplicationController #ActionController::Base
	skip_before_action :verify_authenticity_token, only: :tag
	before_action :allow_any_origin
	before_action :find_segment

	def tag
		if @segment
			respond_to do |format|
				format.html { head 204 }
				format.js { render "segments/segment" }
			end
		else
			head 204
		end
	end


	private

		def find_segment
			referrer = URI.parse(segment_params[:d])
			website = Website.find_by(domain_name: referrer.host)
			return unless website

			if website.pages.exclude?(referrer)
				website.pages.push(referrer)
			end
			# TODO - decisioning wrt include vs exclude segments, conversion tags
			@segment = website.campaign.include_segment if website.campaign && website.campaign.include_segment
		end

		def segment_params
			params.permit(:d)
		end

		def allow_any_origin
			headers["Access-Control-Allow-Origin"] = "*"
		end

end