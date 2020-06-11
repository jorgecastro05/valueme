// This is a manifest file that'll be compiled into application.js.
//
// Any JavaScript file within this directory can be referenced here using a relative path.
//
// You're free to add application-wide JavaScript to this file, but it's generally better
// to create separate JavaScript files as needed.
//
// los javascripts a continuación se llaman en orden, en ultimo lugar se ejecuta este archivo
//
//= require jquery-2.2.0.min
//= require angular.min.js
//= require angular-resource.min.js
//= require angular-route.min.js
//= require angular-app.js
//= require_tree .
//= require_self

// initialize close button on messages
$('.message .close')
    .on('click', function() {
        $(this)
            .closest('.message')
            .transition('fade');
    });


// initialize dropdown
$('.ui.dropdown')
    .dropdown({
        fullTextSearch: true
    });


// initialize checkbox
$('.ui.checkbox')
    .checkbox();

$('.ui.radio.checkbox')
    .checkbox();

// initialize accordion
$('.ui.accordion')
    .accordion({
        exclusive: false
    });

$('.ui.horizontal.accordion')
    .accordion({
        exclusive: false
    });

// initialize help popup
$('.help')
    .popup({
        duration: 200
    });

// initialize progress bar
$('.progress')
    .progress();

// initialize calendar
$('#rangestart').calendar({
    type: 'date',
    monthFirst: false,
    formatter: {
        date: function(date, settings) {
            if (!date) return '';
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            return day + '/' + month + '/' + year;
        }
    },
    endCalendar: $('#rangeend')
});
$('#rangeend').calendar({
    type: 'date',
    monthFirst: false,
    formatter: {
        date: function(date, settings) {
            if (!date) return '';
            var day = date.getDate();
            var month = date.getMonth() + 1;
            var year = date.getFullYear();
            return day + '/' + month + '/' + year;
        }
    },
    startCalendar: $('#rangestart')
});

// calendar selector year
$('#yearDate, .yearDate').calendar({
    type: 'year'
});

// show modal for copy surveys by vigency
$('.copySurveyVigency').click(function(){
    $('#copySurveyVigency').modal('show');
});

// show modal for copy surveys by category
$('.copySurveyCategory').click(function(){
    $('#copySurveyCategory').modal('show');
});

// maphiglight process map
$('.map').maphilight();
