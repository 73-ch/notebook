$(document).ready(function() {
    $('#calendar').fullCalendar({
    	 events: '/date/json',
    	 header: {
	    	left: "today",
	    	center: "prev,next",
	    	right:  'month,agendaWeek,agendaDay',
    	},
    	 nowIndicator: false,
    	 editable: true,
    })
});