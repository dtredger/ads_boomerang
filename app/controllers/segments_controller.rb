class SegmentsController < ApplicationController #ActionController::Base
	skip_before_action :verify_authenticity_token, only: :tag

	before_action :allow_any_origin
	before_action :find_website

	caches_action :tag, :cache_path => Proc.new { |c| c.request.url }

	def tag
		if @website && @segment_tag
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

			referrer_str = params[:s]
			if @website.pages.exclude?(referrer_str)
				@website.pages.push(referrer_str)
				@website.save
			end

			# TODO - decisioning wrt include vs exclude segments, conversion tags
			if @website.campaign && @website.campaign.include_segment
				@segment_tag = @website.campaign.include_segment.retarget_src
			end
		end

		def allow_any_origin
			headers["Access-Control-Allow-Origin"] = "*"
		end

end