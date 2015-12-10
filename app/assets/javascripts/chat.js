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
