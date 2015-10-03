require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { description: @event.description, end_date: @event.end_date, end_time: @event.end_time, end_time_flex_amount: @event.end_time_flex_amount, estimated_time_required: @event.estimated_time_required, location: @event.location, may_split: @event.may_split, priority: @event.priority, short_description: @event.short_description, start_date: @event.start_date, start_time: @event.start_time, start_time_flex_amount: @event.start_time_flex_amount }
    end

    assert_redirected_to event_path(assigns(:event))
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { description: @event.description, end_date: @event.end_date, end_time: @event.end_time, end_time_flex_amount: @event.end_time_flex_amount, estimated_time_required: @event.estimated_time_required, location: @event.location, may_split: @event.may_split, priority: @event.priority, short_description: @event.short_description, start_date: @event.start_date, start_time: @event.start_time, start_time_flex_amount: @event.start_time_flex_amount }
    assert_redirected_to event_path(assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
