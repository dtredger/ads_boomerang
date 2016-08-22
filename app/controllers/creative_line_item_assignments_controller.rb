class CreativeLineItemAssignmentsController < ApplicationController
  before_action :set_creative_line_item_assignment, only: [:show, :edit, :update, :destroy]

  # GET /creative_line_item_assignments
  # GET /creative_line_item_assignments.json
  def index
    @creative_line_item_assignments = CreativeLineItemAssignment.all
  end

  # GET /creative_line_item_assignments/1
  # GET /creative_line_item_assignments/1.json
  def show
  end

  # GET /creative_line_item_assignments/new
  def new
    @creative_line_item_assignment = CreativeLineItemAssignment.new
  end

  # GET /creative_line_item_assignments/1/edit
  def edit
  end

  # POST /creative_line_item_assignments
  # POST /creative_line_item_assignments.json
  def create
    @creative_line_item_assignment = CreativeLineItemAssignment.new(creative_line_item_assignment_params)

    respond_to do |format|
      if @creative_line_item_assignment.save
        format.html { redirect_to @creative_line_item_assignment, notice: 'Creative line item assignment was successfully created.' }
        format.json { render :show, status: :created, location: @creative_line_item_assignment }
      else
        format.html { render :new }
        format.json { render json: @creative_line_item_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /creative_line_item_assignments/1
  # PATCH/PUT /creative_line_item_assignments/1.json
  def update
    respond_to do |format|
      if @creative_line_item_assignment.update(creative_line_item_assignment_params)
        format.html { redirect_to @creative_line_item_assignment, notice: 'Creative line item assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @creative_line_item_assignment }
      else
        format.html { render :edit }
        format.json { render json: @creative_line_item_assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /creative_line_item_assignments/1
  # DELETE /creative_line_item_assignments/1.json
  def destroy
    @creative_line_item_assignment.destroy
    respond_to do |format|
      format.html { redirect_to creative_line_item_assignments_url, notice: 'Creative line item assignment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_creative_line_item_assignment
      @creative_line_item_assignment = CreativeLineItemAssignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def creative_line_item_assignment_params
      params.fetch(:creative_line_item_assignment, {})
    end
end
