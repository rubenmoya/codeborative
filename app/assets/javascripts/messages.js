var pusher = new Pusher('d54e445214f40cbfce02', {
  authEndpoint: '/pusher/auth'
});

var channel = pusher.subscribe('messages-channel');

channel.bind('pusher:subscription_succeeded', function() {
  channel.bind('update-chat-' + $('meta[name=user_id]').attr("id"), function(data) {
    var id = data.conversation_id;
    var chatbox = $("#chatbox_" + data.conversation_id + " .chatboxcontent");
    var sender_id = data.sender.id;
    var reciever_id = $('meta[name=user_id]').attr("id");

    chatbox.append(
      '<li class="' + data.self_or_other + '">' +
        '<div class="avatar">' +
          '<img src="' + data.sender.avatar + '"/>' +
        '</div>' +
        '<div class="chatboxmessagecontent">' +
          '<p>' + data.message.body + '</p>' +
          '<time datetime="' + data.message.created_at + '" title="' + data.message.date + '">' + data.sender.name + ' • ' + data.message.date + '</time>' +
        '</div>' +
      '</li>');

    chatbox.scrollTop(chatbox.scrollHeight);

    if(sender_id != reciever_id){
    	chatBox.chatWith(id);
      chatbox.children().last().removeClass("self").addClass("other");
    	chatbox.scrollTop(chatbox[0].scrollHeight);
      //chatBox.notify();
    }
  });
});
