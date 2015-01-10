# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#
#link to tab
# 
$(document).ready () ->
  activeTab = $("[href=" + window.location.hash + "]")
  activeTab and activeTab.tab("show")
  $("html,body").scrollTop $("body").scrollTop()

#
#change URL hash when switching tabs
# 
$ ->
  hash = window.location.hash
  $(".nav-tabs a").click (e) ->
    window.location.hash = @hash
