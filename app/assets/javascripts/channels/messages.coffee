App.messages = App.cable.subscriptions.create 'MessagesChannel',
  received: (data) ->
    $('.MessageList').append @renderMessage(data)
    $('#js-message-input').val("")
    chatToBottom()

  renderMessage: (data) ->
    "<div class='Message'>
      <img class='Message-pic' src='#{data.user.avatar}' />
      <div class='Message-body'>
        <h1>
          #{data.user.name}
          <span class='date'>#{data.time}</span>
        </h1>
        <div class='text'>
          #{data.body}
        </div>
      </div>
    </div>"
