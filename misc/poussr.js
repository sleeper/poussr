/*
 *
 */

var Poussr = function(host, port, channel) {
  this.host = host;
  this.port = port;
  this.channel = channel;
  this.connected = false;

  this.connect();
}


Poussr.prototype = {
  channel: function() { return this.channel; },
  host: function() { return this.host; },
  port: function() { return this.port; },

  connect: function() {
    var url = "ws://" + this.host + ":" + this.port + "/";

    /* FIXME: TO BE CONTINUED */

  }
};
