// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    // page is now ready, initialize the calendar...
    $('#calendar').fullCalendar({
        // weekends: false // will hide Saturdays and Sundays
        dayClick: function() {
        alert('Add Task! To be implemented in next sprint');
    	}
    })

});