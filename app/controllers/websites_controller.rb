class WebsitesController < ApplicationController
	before_action :authenticate_advertiser!
	before_action :set_website, only: [:show, :edit, :update, :destroy]


  def index
    @websites = current_advertiser.websites
  end

  def show
  end

  def new
    @website = Website.new
  end

  def edit
  end

  def create
    @website = Website.new(website_params)
    @website.advertiser = current_advertiser
    @website.pages = {all: [website_params[:domain_name]], add: [], exclude:[]}
    @website.domain_name = URI.parse(website_params[:domain_name]).host
    @website.hosting_provider = params[:website][:hosting_provider].to_i
    if @website.save
      redirect_to @website, notice: 'Website was successfully created.'
    else
      render :new
    end
  end

  def update
    if @website.update(website_params)
      redirect_to @website, notice: 'Website was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @website.destroy
    redirect_to websites_url, notice: 'Website was successfully deleted.'
  end

  private
    def set_website
      @website = current_advertiser.websites.find(params[:id])
    end

    def website_params
      params.fetch(:website, {}).permit(:name, :domain_name, :notes)
    end
end
