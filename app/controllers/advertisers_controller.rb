class AdvertisersController < ApplicationController
  before_action :set_advertiser, only: [:show, :edit, :update, :destroy]


  def show
  end

  def new
    @advertiser = Advertiser.new
  end

  def edit
  end

  def create
    @advertiser = Advertiser.new(advertiser_params)

    if @advertiser.save
      format.html { redirect_to @advertiser, notice: 'Advertiser was successfully created.' }
    else
      format.html { render :new }
    end
  end

  def update
    if @advertiser.update(advertiser_params)
      format.html { redirect_to @advertiser, notice: 'Advertiser was successfully updated.' }
    else
      format.html { render :edit }
    end
  end

  def destroy
    @advertiser.destroy
    format.html { redirect_to advertisers_url, notice: 'Advertiser was successfully destroyed.' }
  end

  private
    def set_advertiser
      @advertiser = Advertiser.find(params[:id])
    end

    def advertiser_params
      params.fetch(:advertiser, {})
    end
end
