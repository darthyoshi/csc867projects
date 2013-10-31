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
    for i in [0..23]
        $('#hour').append("<option>"+(if i < 10 then ("0" + i) else i)+"</option>")
    for i in [0..59]
        $('#min').append("<option>"+(if i < 10 then ("0" + i) else i)+"</option>")
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
    update_title()
    $(".cur_month").text(months[cur_month]+' '+cur_year)
    for i in [0..35] by 7
        if i-cur_first < num_days
            $("#month").append(gen_week(i-cur_first))

###
generates a table row containing a week of the current month
###
gen_week = (sunday) ->
    result = "<tr>"
    for i in [1..7]
        if sunday+i >= 1 and sunday+i <= num_days
            result = result + "<td class='day'"
            if (sunday+i-today) == 0
                result += " id='selected'"
            result += "><p>" + (i+sunday) + "</p></td>"
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
selects the cell that is clicked on
###
$(document).on('click', '.day', ( ->
    today = $(this).children('p:first-child').text()
    $('#selected').attr('id',"")
    $(this).attr('id','selected')
    update_title()
));

###
post the note when the submit button is clicked
###
$(document).on('click', '.add_note', ( ->
    post_note()
));

###
posts the note time and text into the appropriate date on the calendar and resets the form fields
###
post_note = () ->
    if $('#note').val().trim() != ""
        result = "<p>" + $('#hour').val() + ":" + $('#min').val() + "<br><i>" + $('#note').val() + "</i></p>"
        $("#selected").append(result)
        $('#note').val("")
        $('#hour').val("00")
        $('#min').val("00")
    else
        alert("Please enter a note!")

###
updates the form text to reflect the currently selected date
###
update_title = () ->
    $('#title').text("Note for "+(if today < 10 then ("0"+today) else today)+'-'+months[cur_month]+'-'+cur_year)

###
posts the note when the enter key is pressed while the text box is in focus
###
$(document).on('keydown', '#note', ((e) ->
    if e.keyCode is 13
        post_note()
));
