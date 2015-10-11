// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function() {
    // page is now ready, initialize the calendar...
    $('#calendar').fullCalendar({
    	header: { center: 'month,agendaWeek' },
    	events: '/events.json',
        // weekends: false // will hide Saturdays and Sundays
        //dayClick: function() {
        //alert('Add Task! To be implemented in next sprint');
    	//}
        eventClick:  function(event, jsEvent, view) {
        //set the values and open the modal
        $("#eventInfo").html(event.short_description);
        $("#startTime").html(moment(event.start).format('MMM Do h:mm A'));
        //$("#endTime").html(event.end);
        $("#eventLink").attr('href', event.url);
        $("#eventContent").dialog({ modal: true, title: event.title });
        return false;
    }
    })
});
