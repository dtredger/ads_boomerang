class CampaignsController < ApplicationController
	before_action :authenticate_advertiser!
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]

  def index
    @campaigns = current_advertiser.campaigns
  end

  def show
  end

  def new
    @campaign = Campaign.new
  end

  def edit
  end

  def create
    @campaign = Campaign.new(campaign_params)
		@campaign.advertiser = current_advertiser
    if @campaign.save
      redirect_to website_path(campaign_params[:website_id]), notice: 'Campaign was successfully created.'
    else
      render :new
    end
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to website_path(@campaign.website), notice: 'Campaign was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.'
  end

  private
    def set_campaign
      @campaign = current_advertiser.campaigns.find_by_id(params[:id])
      redirect_to campaigns_url unless @campaign
			@campaign
    end

    def campaign_params
      params.fetch(:campaign, {}).permit(:name, :website_id, :clickthrough_url)
    end
end
