App.beeswax = App.cable.subscriptions.create("BeeswaxChannel", {
  connected: function() {
    //showNotification("info", "Connected to AdsDash");
  },

  disconnected: function() {
    //showNotification("warning", "Disconnected from AdsDash");
  },

  received: function(data) {
    // Called when there's incoming data on the websocket for this channel
    showNotification("info", data.message);
  }

});

//var type = ['','info','success','warning','danger'];
var showNotification = function(type, message) {
  $.notify({
        icon: 'pe-7s-speaker',
        message: message
      },{
        type: type,
        timer: 2000,
        placement: { from: "top", align: "center" }
      }
  );
};






