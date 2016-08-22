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
      redirect_to @advertiser, notice: 'Advertiser was successfully created.'
    else
      render :new
    end
  end

  def update
    if @advertiser.update(advertiser_params)
      redirect_to @advertiser, notice: 'Advertiser was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @advertiser.destroy
    redirect_to advertisers_url, notice: 'Advertiser was successfully destroyed.'
  end

  private
    def set_advertiser
      @advertiser = current_advertiser
    end

    def advertiser_params
      params.fetch(:advertiser, {})
    end
end
