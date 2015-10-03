require 'test_helper'

class EventInstancesControllerTest < ActionController::TestCase
  setup do
    @event_instance = event_instances(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_instances)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_instance" do
    assert_difference('EventInstance.count') do
      post :create, event_instance: { completed: @event_instance.completed, dismissed: @event_instance.dismissed, event_id: @event_instance.event_id, location: @event_instance.location, scheduled_end: @event_instance.scheduled_end, scheduled_start: @event_instance.scheduled_start }
    end

    assert_redirected_to event_instance_path(assigns(:event_instance))
  end

  test "should show event_instance" do
    get :show, id: @event_instance
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_instance
    assert_response :success
  end

  test "should update event_instance" do
    patch :update, id: @event_instance, event_instance: { completed: @event_instance.completed, dismissed: @event_instance.dismissed, event_id: @event_instance.event_id, location: @event_instance.location, scheduled_end: @event_instance.scheduled_end, scheduled_start: @event_instance.scheduled_start }
    assert_redirected_to event_instance_path(assigns(:event_instance))
  end

  test "should destroy event_instance" do
    assert_difference('EventInstance.count', -1) do
      delete :destroy, id: @event_instance
    end

    assert_redirected_to event_instances_path
  end
end
