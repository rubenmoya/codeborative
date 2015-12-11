var pusher = new Pusher('d54e445214f40cbfce02', {
  authEndpoint: '/pusher/auth'
});

var channel = pusher.subscribe('messages-channel');

channel.bind('pusher:subscription_succeeded', function() {
  channel.bind('update-chat-' + $('.MessageList').data("conversation-id"), function(data) {
    $('.MessageList').append('\
      <div class="Message">\
        <img src="' + data.user.avatar + '" class="Message-pic" />\
        <div class="Message-body">\
          <h1>\
            '+ data.user.name + '\
            <span class="date">\
              '+ data.message.created_at + '\
            </span>\
          </h1>\
          <div class="text">\
            '+ data.message.body + '\
          </div>\
        </div>\
      </div>');

    chatToBottom();
    $('#js-message-input').val("");
  });
});


$(document).on('page:change', function(){
  chatToBottom();
});

function chatToBottom() {
  var messageList = $('.MessageList');
  if(messageList.length > 0) {
    var height = messageList[0].scrollHeight;
    messageList.scrollTop(height);
  }
}
