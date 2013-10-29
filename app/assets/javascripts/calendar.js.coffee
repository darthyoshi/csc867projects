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

$(document).ready () ->
    $('#carousel').append(list_days())
    for i in [0..23]
        $('#hour').append("<option>"+(if i < 10 then ("0" + i) else i)+"</option>")
    for i in [0..59]
        $('#min').append("<option>"+(if i < 10 then ("0" + i) else i)+"</option>")
    init()

list_days = () ->
    result = "<tr>"
    for i in days
        result = result + "<th>" + i + "</th>"
    result += "</tr>"

init = () ->
    $(".cur_month").text(months[cur_month]+' '+cur_year)
    for i in [0..35] by 7
        if i-cur_first < num_days
            $(".month").append(gen_week(i-cur_first))

gen_week = (sunday) ->
    result = "<tr>"
    for i in [0..6] by 1
        if sunday >= 0 and sunday < num_days
            result = result + "<td class=\'day"
            if (1+sunday) == (new Date()).getDate()
                result += " today"
            result = result + "\' id=\'" + (1+sunday) + "\'>" + (1+sunday) + "</td>"
        else
            result += "<td class=\'empty\'></td>"
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

$(document).on('click', '.day', ( ->
    id = $(this).attr('id')
    blah = $('#'+id+" > p").html().replace("<br>",'\n')
    alert(blah)
));

$(document).on('click', '.add_note', ( ->
    post_note()
));

$(document).on('keydown', '#note', ((event) =>
    if event.keyCode is '13'
        post_note()
));

post_note = () ->
    if $('#note').val() != ""
        result = "<p>" + $('#hour').val() + ":" + $('#min').val() + "<br>" + $('#note').val() + "</p>"
        $("#"+(new Date()).getDate()).append(result)
        $('#note').val("")
