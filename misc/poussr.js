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

    this.connection = new WebSocket(url);
    
    var poussr = this;

    this.connection.onmessage = function() {
      poussr.onmessage.apply(poussr, arguments);
    };
    this.connection.onclose = function() {
      poussr.onclose.apply(poussr, arguments);
    };
    this.connection.onopen = function() {
      poussrf.onopen.apply(poussr, arguments);
    };

    /* FIXME: TO BE CONTINUED */
  },

  /*
   * Received message is supposed to be of the following format:
   *   'channel': <channel name>
   *   'event': <name of the event>
   *   'data': additional data associated to the event
   *
   */   
  onmessage: function(evt) {
    var params = Poussr.parse(evt.data);
    var event_name = params.event;
    var evt_data = Poussr.parse(params.data);
    car channel_name = params.channel;
        
    this.send_local_event(event_name, event_data, channel_name);
  },

  /* TO BE IMPLEMENTED: 
     - send_local_event
     - onclose
     - onopen
     */

};

Poussr.log = function(msg) { console.log(msg); }

Poussr.parse = function(data) {
    try {
    return JSON.parse(data);
  } catch(e) {
    Poussr.log("Poussr : data is not valid JSON.");
    return data;
  }
}
