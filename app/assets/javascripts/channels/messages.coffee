App.messages = App.cable.subscriptions.create "MessagesChannel",
  collection: -> $("[data-channel='messages']")

  connected: ->
    setTimeout =>
      @followCurrentConversation()
      @installPageChangeCallback()
    , 1000

  received: (data) ->
    @collection().append(data.message)
    chatToBottom()

  followCurrentConversation: ->
    if conversationId = @collection().data('conversation-id')
      console.log("it works")
      @perform 'follow', conversation_id: conversationId
    else
      console.log("it doesnt work")
      @perform 'unfollow'

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'page:change', -> App.comments.followCurrentConversation()
