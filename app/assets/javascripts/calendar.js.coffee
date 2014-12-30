# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

days = [
    "Sun", "Mon", "Tue", "Wed",
    "Thu", "Fri", "Sat"
]

months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun",
    "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
]

cur_year = (new Date()).getFullYear()
cur_month = (new Date()).getMonth()
cur_first = (new Date(cur_year, cur_month, 1, 0, 0, 0, 0)).getDay()
today = (new Date()).getDate()
num_days = (new Date(cur_year, cur_month+1, 0)).getDate()

###
generates the calendar content when the page is first loaded
###
$(document).ready () ->
    $('#carousel').append(list_days())
    init()

###
generates a table row containing the day names
###
list_days = () ->
    result = "<tr>"
    for i in days
        result = result + "<th>" + i + "</th>"
    result += "</tr>"

###
generates the calendar content based on the current month and date
###
init = () ->
    $(".cur_month").text(months[cur_month]+' '+cur_year)
    for i in [0..35] by 7
        if i-cur_first < num_days
            $("#month").append(gen_week(i-cur_first))
    $.getJSON("/projects/appointments/" + (cur_month+1) + '/' + cur_year + ".json", ((data) ->
        for j in (data)
            $('#'+j["date"]).append("<p>" + j["time"] + "<br><i>" + j["desc"] + "</i></p>")
    ));

###
generates a table row containing a week of the current month
###
gen_week = (sunday) ->
    result = "<tr>"
    for i in [1..7]
        if sunday+i >= 1 and sunday+i <= num_days
            result = result + "<td class='day' id='" + (sunday+i) + "'><p>" + (i+sunday) + "</p></td>"
        else
            result += "<td class='empty'></td>"
    result += "</tr>"

###
updates the calendar content
###
update = () ->
    cur_first = (new Date(cur_year, cur_month, 1, 0, 0, 0, 0)).getDay()
    num_days = (new Date(cur_year, cur_month+1, 0)).getDate()
    if today > num_days
        today = num_days
    $("#month").empty()
    init()

###
decrements the year
###
$(document).on('click', '#prev_year', ( ->
    cur_year--
    update()
));

###
decrements the month
###
$(document).on('click', '#prev_month', ( ->
    if cur_month > 0
        cur_month--
    else
        cur_month = 11
        cur_year--
    update()
));

###
increments the month
###
$(document).on('click', '#next_month', ( ->
    if cur_month < 11
        cur_month++
    else
        cur_month = 0
        cur_year++
    update()
));

###
increments the year
###
$(document).on('click', '#next_year', ( ->
    cur_year++
    update()
));

###
posts the note time and text into the appropriate date on the calendar and resets the form fields
###
$(document).on('click', '.day', ( ->
    today = parseInt($(this).children('p:first-child').text())
    hour = parseInt($('#hour').val())
    min = parseInt($('#min').val())
    note = $('#note').val().trim()
    if note != "" and min != "" and hour != ""
        $('#note').val("")
        $('#hour').val("")
        $('#min').val("")
        if !isNaN(hour) and hour < 24 and hour >= 0 and !isNaN(min) and min < 60 and min >= 0
            appointment = {
                date: today
                month: cur_month
                year: cur_year
                time: (if hour < 10 then '0' + hour else hour) + ":" + (if min < 10 then '0' + min else min)
                desc: note
            }
            $.ajax({
                type: "POST",
                url: "/projects/appointments/send"
                data: JSON.stringify(appointment),
                statusCode: {
                    201: ( -> (
                        $('#'+today).append("<p>" + appointment["time"] + "<br><i>" + note + "</i></p>")
                    ))
                },
                dataType: "html",
                contentType: "application/json"
            })
        else
            alert("Please enter a valid input.")
));
