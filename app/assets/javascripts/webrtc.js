var SimplePeer = window.SimplePeer;
var currentUser;
var peer = undefined;

var pusher = new Pusher('d54e445214f40cbfce02', {
  authEndpoint: '/pusher/auth'
});

var channel = pusher.subscribe('presence-chat');

channel.bind('pusher:subscription_succeeded', function() {
  currentUser = channel.members.me;

  channel.bind('client-signal-' + currentUser.id, function(signal) {
    if (peer === undefined) {
      navigator.webkitGetUserMedia({ video: true, audio: true },
        function(stream) {

          peer = new SimplePeer({ initiator: false, trickle: false, stream: stream });

          peer.signal(signal.data)

          peer.on('signal', function (data) {
            channel.trigger('client-signal-' + signal.userId, { userId: currentUser.id, data: data });
          });

          peer.on('stream', function (stream) {
            console.log(stream)
            var video = document.querySelector('video')
            video.src = window.URL.createObjectURL(stream)
            video.play()
          });
        },
        function () {
          console.log('Error :(');
        })
    } else {
      peer.signal(signal.data)
    }
  });
});

function makeCall(peerUserId) {
  navigator.webkitGetUserMedia({ video: true,audio: true },
    function(stream) {
      peer = new SimplePeer({ initiator: true, trickle: false, stream:    stream });

      peer.on('signal', function (data) {
        channel.trigger('client-signal-' + peerUserId, { userId: currentUser.id, data: data });
      });

      peer.on('stream', function (stream) {
        console.log(stream)
        var video = document.querySelector('video')
        video.src = window.URL.createObjectURL(stream)
        video.play()
      });
    },
    function () {
      console.log('Error :(');
    })
}
