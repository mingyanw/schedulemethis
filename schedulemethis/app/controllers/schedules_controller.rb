class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :update, :destroy]

  # GET /schedules
  # GET /schedules.json
  def index
    @schedules = Schedule.all
  end

  #Dashboard View
  def dashboard
    if !user_signed_in?
      redirect_to new_user_session_url
    else
      @schedule = Schedule.all.where(user_id: current_user.id).first
      @events = nil
      if !@schedule.nil?
        # All Events in the User's Schedule 
        @events = Event.all.where(schedule_id: @schedule.id)
        # Today's Event 
        @todays_events = @events.eventsThisWeek.first;
        @remaining_events = @events.remainingEventsToday;
      end
    end
  end

  #Calendar View
  def calendar
    if !user_signed_in?
      redirect_to new_user_session_url
    else
      @events = Event.all
      @event = Event.new
    end
  end

  #Agenda View 
  def agenda
    # Pass in an array of days of the week and the events on those days
    @this_week_events = Event.eventsThisWeek;
  end

  # GET /schedules/1
  # GET /schedules/1.json
  def show
  end

  # GET /schedules/new
  def new
    @schedule = Schedule.new
  end

  # GET /schedules/1/edit
  def edit
  end

  # POST /schedules
  # POST /schedules.json
  def create
    @schedule = Schedule.new(schedule_params)

    respond_to do |format|
      if @schedule.save
        format.html { redirect_to @schedule, notice: 'Schedule was successfully created.' }
        format.json { render :show, status: :created, location: @schedule }
      else
        format.html { render :new }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schedules/1
  # PATCH/PUT /schedules/1.json
  def update
    respond_to do |format|
      if @schedule.update(schedule_params)
        format.html { redirect_to @schedule, notice: 'Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @schedule }
      else
        format.html { render :edit }
        format.json { render json: @schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schedules/1
  # DELETE /schedules/1.json
  def destroy
    @schedule.destroy
    respond_to do |format|
      format.html { redirect_to schedules_url, notice: 'Schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:user_id)
    end
end
