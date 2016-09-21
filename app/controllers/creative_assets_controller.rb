class CreativeAssetsController < ApplicationController
	before_action :authenticate_advertiser!
	before_action :set_creative_asset, only: [:show, :edit, :update, :destroy]

	def index
		@creative_assets = current_advertiser.creative_assets
	end

	def show
	end

	def new
		@creative_asset = CreativeAsset.new
	end

	def edit
	end

	def create
		@creative_asset = CreativeAsset.new(creative_params)
		@creative_asset.advertiser = current_advertiser
		if @creative_asset.save
			redirect_to @creative_asset, notice: 'Creative was successfully created.'
		else
			render :new
		end
	end

	def update
		if @creative_asset.update(creative_params)
			redirect_to @creative_asset, notice: 'Creative was successfully updated.'
		else
			render :edit
		end
	end

	def destroy
		@creative_asset.destroy
		redirect_to creative_assets_url, notice: 'Creative was successfully destroyed.'
	end

	private
	def set_creative_asset
		@creative_asset = current_advertiser.creative_assets.find_by_id(params[:id])
		redirect_to creative_assets_url unless @creative_asset
		@creative_asset
	end

	def creative_params
		params.fetch(:creative, {}).permit(:mounted_asset)
	end
end
