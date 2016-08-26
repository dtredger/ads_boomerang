class SubscriptionPlansController < ApplicationController
  before_action :set_subscription_plan, only: [:show, :edit, :update, :destroy]

  # GET /subscription_plans
  def index
    @subscription_plans = SubscriptionPlan.all
  end

  # GET /subscription_plans/1
  def show
  end

  # GET /subscription_plans/new
  def new
    @subscription_plan = SubscriptionPlan.new
  end

  # GET /subscription_plans/1/edit
  def edit
  end

  # POST /subscription_plans
  def create
    @subscription_plan = SubscriptionPlan.new(subscription_plan_params)

    if @subscription_plan.save
      redirect_to @subscription_plan, notice: 'Subscription plan was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /subscription_plans/1
  def update
    if @subscription_plan.update(subscription_plan_params)
      redirect_to @subscription_plan, notice: 'Subscription plan was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /subscription_plans/1
  def destroy
    @subscription_plan.destroy
    redirect_to subscription_plans_url, notice: 'Subscription plan was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription_plan
      @subscription_plan = SubscriptionPlan.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subscription_plan_params
      params.fetch(:subscription_plan, {})
    end
end
