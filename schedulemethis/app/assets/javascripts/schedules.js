// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ready;

// Have to wrap everything in document.ready in the function below 
// to work-around the Turbolinks/JS issue
// Suggested by Stackoverflow post: 
// http://stackoverflow.com/questions/18770517/rails-4-how-to-use-document-ready-with-turbo-links
ready = function() {
    // Load & display calendar 
    $('#calendar').fullCalendar({
        header: { center: 'month,agendaWeek' },
        events: '/events.json',
        eventClick:  function(event, jsEvent, view) {
        //set the values and open the modal
        $("#eventInfo").html(event.short_description);
        $("#startTime").html("Start: " + moment(event.start).format('MMM Do h:mm A'));
        //$("#endTime").html("End: " + moment(event.end).format('MMM Do h:mm A'));
        $("#eventLink").attr('href', event.url);
        $("#eventContent").dialog({ modal: true, title: event.title });
        return false;
        }
    }) 
};


// Execute the functions when document is ready/loaded 
$(document).ready(ready);
$(document).on('page:load', ready);


