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

cur_month = (new Date()).getMonth();
cur_year =  (new Date()).getFullYear();
cur_first = (new Date(cur_year, cur_month, 1, 0, 0, 0, 0)).getDay();

$(document).ready ->
    init()

init = () ->
    $(".cur_month").text((new Date).getDate()+' '+months[cur_month]+' '+cur_year)
    $(".month").append(gen_week())

gen_week = () ->
    result = "<tr>"
    for i in [0..cur_first] by 1
        result += "<td></td>"
    result += "</tr>"
