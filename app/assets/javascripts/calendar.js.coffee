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



$(document).ready ->
    init()

init = () ->
    $(".cur_month").text((new Date).getDate()+' '+months[cur_month]+' '+cur_year)
    $(".month").append("<tr><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td></tr>")
