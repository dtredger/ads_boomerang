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
			refer_uri = URI.parse(segment_params[:d])
			@website = Website.find_by(domain_name: refer_uri.host)
			return unless @website
			if @website.pages.exclude?(refer_uri.to_s)
				@website.pages.push(refer_uri.to_s)
				@website.save
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