// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$('.datepicker').pickadate({
    selectMonths: true, // Creates a dropdown to control month
    selectYears: 3 // Creates a dropdown of 15 years to control year
  });

function reschedule(id){
	$.ajax("/reset_times/" + id); //add id to params and set up route
}

function finished(id){
	$.ajax("/finished_event/" + id);
}