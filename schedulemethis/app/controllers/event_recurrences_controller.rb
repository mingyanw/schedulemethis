class EventRecurrencesController < ApplicationController
  before_action :set_event_recurrence, only: [:show, :edit, :update, :destroy]

  # GET /event_recurrences
  # GET /event_recurrences.json
  def index
    @event_recurrences = EventRecurrence.all
  end

  # GET /event_recurrences/1
  # GET /event_recurrences/1.json
  def show
  end

  # GET /event_recurrences/new
  def new
    @event_recurrence = EventRecurrence.new
  end

  # GET /event_recurrences/1/edit
  def edit
  end

  # POST /event_recurrences
  # POST /event_recurrences.json
  def create
    @event_recurrence = EventRecurrence.new(event_recurrence_params)

    respond_to do |format|
      if @event_recurrence.save
        format.html { redirect_to @event_recurrence, notice: 'Event recurrence was successfully created.' }
        format.json { render :show, status: :created, location: @event_recurrence }
      else
        format.html { render :new }
        format.json { render json: @event_recurrence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_recurrences/1
  # PATCH/PUT /event_recurrences/1.json
  def update
    respond_to do |format|
      if @event_recurrence.update(event_recurrence_params)
        format.html { redirect_to @event_recurrence, notice: 'Event recurrence was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_recurrence }
      else
        format.html { render :edit }
        format.json { render json: @event_recurrence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_recurrences/1
  # DELETE /event_recurrences/1.json
  def destroy
    @event_recurrence.destroy
    respond_to do |format|
      format.html { redirect_to event_recurrences_url, notice: 'Event recurrence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_recurrence
      @event_recurrence = EventRecurrence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_recurrence_params
      params.require(:event_recurrence).permit(:event_id, :even_weeks, :odd_weeks, :yearly, :months, :days, :auto_dismiss)
    end
end
