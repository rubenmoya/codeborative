App.documents = App.cable.subscriptions.create "DocumentsChannel",
  document: -> $("[data-channel='document']")

  connected: ->
    $(document).on "keyup", "[data-channel='document']", =>
      $.ajax(
        url: "/documents/" + @document().data('document-id'),
        dataType: "JSON",
        method: "PUT",
        data: {text: @document().val()}
      )

    setTimeout =>
      @followCurrentDocument()
    , 1000

  received: (data) ->
    unless @document().is(':focus')
      @document().text(data.text)

  followCurrentDocument: ->
    if documentId = @document().data('document-id')
      @perform 'follow', document_id: documentId
    else
      @perform 'unfollow'
