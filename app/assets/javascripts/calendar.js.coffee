# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

selected_date = new Date();

$(document).ready ->
    init()

init = () ->
    $(".cur_month").text(selected_date.getMonth()+' '+selected_date.getFullYear())
