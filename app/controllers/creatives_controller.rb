class CreativesController < ApplicationController
	before_action :authenticate_advertiser!
  before_action :set_creative, only: [:show, :edit, :update, :destroy]

  def index
    @creatives = current_advertiser.creatives
  end

  def show
  end

  def new
    @creative = Creative.new
  end

  def edit
  end

  def create
    @creative = Creative.new(creative_params)
    @creative.advertiser = current_advertiser
    if @creative.save
      redirect_to @creative, notice: 'Creative was successfully created.'
    else
      render :new
    end
  end

  def update
    if @creative.update(creative_params)
      redirect_to @creative, notice: 'Creative was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @creative.destroy
    redirect_to creatives_url, notice: 'Creative was successfully destroyed.'
  end

  private
    def set_creative
      @creative = current_advertiser.creatives.find_by_id(params[:id])
			redirect_to creatives_url unless @creative
			@creative
    end

    def creative_params
      params.fetch(:creative, {}).permit(:name, :creative_asset)
    end
end
