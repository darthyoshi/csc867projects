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
num_days = (new Date(cur_year, cur_month+1, 0)).getDate()

$(document).ready ->
    init()

init = () ->
    $(".cur_month").text(months[cur_month]+' '+cur_year)
    for i in [0..35] by 7
        if i-cur_first < num_days
            $(".month").append(gen_week(i-cur_first))

gen_week = (sunday) ->
    result = "<tr>"
    for i in [0..6] by 1
        if sunday >= 0 and sunday < num_days
            result = result + "<td id=\'day_" + (1+sunday) + "\'>" + (1+sunday) + "</td>"
        else
            result += "<td></td>"
        sunday++    
    result += "</tr>"

update = () ->
    cur_first = (new Date(cur_year, cur_month, 1, 0, 0, 0, 0)).getDay()
    num_days = (new Date(cur_year, cur_month+1, 0)).getDate()
    $(".month").empty()
    init()

$(document).on('click', '#prev_year', ( ->
    cur_year--
    update()
));

$(document).on('click', '#prev_month', ( ->
    if cur_month > 0
        cur_month--
    else
        cur_month = 11
        cur_year--
    update()
));

$(document).on('click', '#next_month', ( ->
    if cur_month < 11
        cur_month++
    else
        cur_month = 0
        cur_year++
    update()
));

$(document).on('click', '#next_year', ( ->
    cur_year++
    update()
));
