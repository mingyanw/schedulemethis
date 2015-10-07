// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    // page is now ready, initialize the calendar...
    $.getJSON('http://localhost:3000/events.json', function(data) {
    // you can access your data here in the "data" variable passed to this success handler
   	window.events = [];
   	var date = $.fullCalendar.moment('2015-10-06T12:00:00');
    for(var i=0; i<data.length; i++){
    	window.events.push({title: data[i].short_description, start: '2015-10-06'})
    }
    console.log(window.events);
	});

    $('#calendar').fullCalendar({
    	header: { center: 'month,agendaWeek' },
    	events: '/events.json',
        // weekends: false // will hide Saturdays and Sundays
        dayClick: function() {
        alert('Add Task! To be implemented in next sprint');
    	}
    })
});