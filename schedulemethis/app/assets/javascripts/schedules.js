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
        eventColor: '#26a69a',
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
      $('.modal-trigger').leanModal({
          dismissible: true, // Modal can be dismissed by clicking outside of the modal
          opacity: .6, // Opacity of modal background
          in_duration: 500, // Transition in duration
          out_duration: 200, // Transition out duration
        }
      );
      
    $('.actions2').click(function() {
        $("#modal1").closeModal();
    }); //closes action2

    // Load & display mini calendar on the Dashboard
    $('#mini_calendar').fullCalendar({
        allDaySlot: false,
        defaultView: 'agendaDay',
        eventColor: '#26a69a',
        events: '/events.json'
    });

    $(document).delegate("#finished", "click", function(){
        $(this).closest('li').hide();
    });

    // When the user clicks on the dismiss link, hide the completed event/task
    $(document).delegate(".dismiss_links", "click", function(){
        $(this).closest('div.remaining-event').hide();
    });

};


// Execute the functions when document is ready/loaded 
$(document).ready(ready);
$(document).on('page:load', ready);

