$(document).ready(function() {
    $('#calendar').fullCalendar({
    	 events: '/event/json',
    })
});