App.beeswax = App.cable.subscriptions.create("BeeswaxChannel", {
  connected: function() {
    $('#events').prepend("<h4>CONNECT</h4>")
  },

  disconnected: function() {
    $('#events').prepend("<h4>DISCONNECT</h4>")
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    $('#events').prepend("<h4>"+ data.message + "</h4>")
  }
});
