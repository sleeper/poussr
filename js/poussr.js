/*
 * This is the communication tube from browser to Poussr
 * Each Poussr object handles one given Poussr channel
 * Client needs to subscribe to the interesting events through the 
 * subscribe method
 */

Poussr = function(host, port, channel_name) {
  this.host = host;
  this.port = port;
  this.channel_name = channel;
  this.callbacks = {};
  this.connected = false;

  this.connect();
};


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

  },

  /*
   * The communication (through websocket) is opened, we need to
   * subscribe to our channel of choice.
   */
  onopen: function() {
    Poussr.log("Sending event 'poussr:subscribe' with channel name:" + this.chnanle_name);

    this.send_event('poussr:subscribe', JSON.stringify({'channel': this.channel_name}));
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
    var channel_name = params.channel;
    /* FIXME: 
       Check the received channel is the same as mine
    */

    this.dispatch_event(event_name, event_data);
  },

  subscribe: function(event_name, callback) {
    this.callbacks[event_name] ||= [];
    this.callbacks[event_name].push( callback );
  },

  dispatch_event: function(evt_name, evt_data) {
    var callbacks = this.callbacks[evt_name];
    
    if (callbacks) {
      for (var i=0; i < callbacks.length; i++) {
        callbacks[i] (event_data);
      }
    }
  },
  
  onclose: function() {
    this.connected = false;
    /* FIXME: Handle the case when the connection went down but we
     * do want to reconnect.
     */
  }
};

Poussr.log = function(msg) { console.log(msg); };

Poussr.parse = function(data) {
    try {
    return JSON.parse(data);
  } catch(e) {
    Poussr.log("Poussr : data is not valid JSON.");
    return data;
  }
};

