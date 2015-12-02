$(document).ready(function() {
    $('#calendar').fullCalendar({
    	 events: '/date/json',
    })
});