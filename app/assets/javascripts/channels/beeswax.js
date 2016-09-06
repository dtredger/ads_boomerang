App.beeswax = App.cable.subscriptions.create("BeeswaxChannel", {
  connected: function() {
    $('#events').prepend("<h2>CONNECT</h2>")
  },

  disconnected: function() {
    $('#events').prepend("<h2>DISCONNECT</h2>")
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    $('#events').prepend("<h2>"+ data.message + "</h2>")
  }
});
