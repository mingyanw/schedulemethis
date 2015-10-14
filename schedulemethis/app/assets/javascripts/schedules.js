// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var ready;

// Have to wrap everything in document.ready in the function below 
// to work-around the Turbolinks/JS issue
// Suggested by Stackoverflow post: 
// http://stackoverflow.com/questions/18770517/rails-4-how-to-use-document-ready-with-turbo-links
ready = function() {
    // Load & display calendar on the Calendar page
    $('#calendar').fullCalendar({
        allDaySlot: false,
        height: 600,
        header: { center: 'month,agendaWeek' },
        events: '/events.json',
        dayClick: function(date, jsEvent, view) {
            $('#modal1').openModal();
        },
        eventClick:  function(event, jsEvent, view) {
        //set the values and open the modal
            $("#eventInfo").html(event.short_description);
            $("#startTime").html("Start: " + moment(event.start).format('MMM Do h:mm A'));
            $("#endTime").html("End: " + moment(event.end).format('MMM Do h:mm A'));
            $("#eventLink").attr('href', event.url);
            $("#eventContent").dialog({ modal: true, title: event.title });
            return false;
        }
    }); //closes full Calendar

    // Handling Modals Interactions for Full Calendar
    $('.modal-trigger').leanModal();
    $('.actions2').click(function() {
        $("#modal1").closeModal();
    }); //closes action2

    // Load & display mini calendar on the Dashboard
    $('#mini_calendar').fullCalendar({
        defaultView: 'agendaDay',
        events: '/events.json'
    });

    $(document).delegate("#finished", "click", function(){
        $(this).closest('div#event_boxes').hide();
    });

};


// Execute the functions when document is ready/loaded 
$(document).ready(ready);
$(document).on('page:load', ready);

