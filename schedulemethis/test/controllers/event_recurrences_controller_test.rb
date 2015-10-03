require 'test_helper'

class EventRecurrencesControllerTest < ActionController::TestCase
  setup do
    @event_recurrence = event_recurrences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_recurrences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_recurrence" do
    assert_difference('EventRecurrence.count') do
      post :create, event_recurrence: { auto_dismiss: @event_recurrence.auto_dismiss, days: @event_recurrence.days, even_weeks: @event_recurrence.even_weeks, event_id: @event_recurrence.event_id, months: @event_recurrence.months, odd_weeks: @event_recurrence.odd_weeks, yearly: @event_recurrence.yearly }
    end

    assert_redirected_to event_recurrence_path(assigns(:event_recurrence))
  end

  test "should show event_recurrence" do
    get :show, id: @event_recurrence
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_recurrence
    assert_response :success
  end

  test "should update event_recurrence" do
    patch :update, id: @event_recurrence, event_recurrence: { auto_dismiss: @event_recurrence.auto_dismiss, days: @event_recurrence.days, even_weeks: @event_recurrence.even_weeks, event_id: @event_recurrence.event_id, months: @event_recurrence.months, odd_weeks: @event_recurrence.odd_weeks, yearly: @event_recurrence.yearly }
    assert_redirected_to event_recurrence_path(assigns(:event_recurrence))
  end

  test "should destroy event_recurrence" do
    assert_difference('EventRecurrence.count', -1) do
      delete :destroy, id: @event_recurrence
    end

    assert_redirected_to event_recurrences_path
  end
end
