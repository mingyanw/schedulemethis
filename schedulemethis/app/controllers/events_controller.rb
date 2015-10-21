class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :finished, :reschedule]
  before_action :all_events, only: [:index, :create, :update, :destroy]
  respond_to :html, :js

  # GET /events
  # GET /events.json
  def index
    if !user_signed_in?
      redirect_to new_user_session_url
    else
      @events = Event.notstatic.notcompleted
    end
  end

  def index_completed
    @events = Event.notstatic.completed
  end

  def index_static
    @events = Event.static
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  def finished
    @event.completed = true
    @event.save
    respond_to do |format|
        format.js { flash[:notice] = "Event #{@event.short_description} was completed"} 
    end
  end

  def reschedule
    @event.start_time = nil
    @event.start_date = nil
    @event.end_time = nil
    @event.save
    respond_to do |format|
      format.js { redirect_to calendar_path, notice: "Event #{@event.short_description} was rescheduled"} 
      #format.html { redirect_to calendar_path, notice: "Event #{@event.short_description} was rescheduled" }
    end
  end

  # POST /events
  # POST /events.json
  def create
    if !user_signed_in?
      redirect_to root_url
    else
      @mySchedule = Schedule.all.where(user_id: current_user.id).first
      if @mySchedule.nil?
        @mySchedule = Schedule.create user_id: current_user.id
        @mySchedule.save!
      end
        @event = Event.new(event_params)
        @event.priority = @event.priority.to_i

        @event.end_time = @event.start_time + (60 * @event.estimated_time_required) if @event.start_time
        @event.schedule = @mySchedule
        @event.save
      respond_to do |format|
        format.js { flash[:notice] = "Event #{@event.short_description} was created"}
        format.html { redirect_to :back }
      end
      #validation?
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
      format.js { flash[:notice] = "Event #{@event.short_description} was removed"}
    end
  end

  private
    def all_events
      @nc_events = Event.all.past.notcompleted
      @rc_events = Event.recently_created.limit(10)
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:short_description, :description, :start_date, :end_date, :start_time, :end_time, :start_time_flex_amount, :end_time_flex_amount, :priority, :may_split, :estimated_time_required, :location)
    end
end
