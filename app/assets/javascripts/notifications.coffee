class Notifications
  constructor: ->
    @notifications  = $("#js-notifications")
    @setup() if @notifications.length > 0

  setup: ->
    $("#js-notifications-link").on "click", @handleClick

    $.ajax(
      url: "notifications.json",
      dataType: "JSON",
      method: "GET",
      success: @handleSuccess
    )

  handleSuccess: (data) ->
    items = $.map data, (notification) ->
      "<li><a href='#{notification.url}'>#{notification.actor} #{notification.action} #{notification.notifiable.type}</a></li>"

    $("#js-notifications-unread-count").text(items.length)
    $("#js-notifications-items").html(items) if items.length > 0

  handleClick: (event) ->
    event.stopImmediatePropagation()

    $.ajax(
      url: "/notifications/mark_as_read",
      dataType: "JSON",
      method: "POST",
      success: ->
        $("#js-notifications-unread-count").text("0")
    )

$(document).on 'page:change', ->
  new Notifications
