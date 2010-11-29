// This is the communication tube from browser to Poussr
// Each Poussr object handles one given Poussr channel
// Client needs to subscribe to the interesting events through the 
// subscribe method
 

var Poussr = function(host, port, channel_name) {
  this._host = host;
  this._port = port;
  this._channel_name = channel_name;
  this._callbacks = {};
  this._connected = false;
};


Poussr.prototype = {
  channel_name: function() { return this._channel_name; },
  host: function() { return this._host; },
  port: function() { return this._port; },
  connected: function() { return this._connected;},

  connect: function() {
    var url = "ws://" + this._host + ":" + this._port + "/";
    var poussr = this;

    this._connection = new WebSocket(url);

    this._connection.onmessage = function() {
      poussr.onmessage.apply(poussr, arguments);
    };
    this._connection.onclose = function() {
      poussr.onclose.apply(poussr, arguments);
    };
    this._connection.onopen = function() {
      poussr.onopen.apply(poussr, arguments);
    };

    this._connected = true;
  },

  /*
   * The communication (through websocket) is opened, we need to
   * subscribe to our channel of choice.
   */
  onopen: function() {
    Poussr.log("Sending event 'poussr:subscribe' with channel name:" + this._channel_name);

    this.send_event('poussr:subscribe', JSON.stringify({'channel': this._channel_name}));
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
    var evt_name = params.event;
    var evt_data = Poussr.parse(params.data);
    var channel_name = params.channel;
    /* FIXME: 
       Check the received channel is the same as mine
    */
    Poussr.log("Received event '" + evt_name + "' with data '" + evt_data + "'");
    this.dispatch_event(evt_name, evt_data);
  },

  subscribe: function(event_name, callback) {
    this._callbacks[event_name] = this._callbacks[event_name] || []
    this._callbacks[event_name].push( callback );
  },

  send_event: function(evt_name, evt_data) { 
    var payload = JSON.stringify({ 'event' : evt_name, 'data' : evt_data });
    Poussr.log("Poussr : sending event : " + payload);
    this._connection.send(payload);
    return this;
  },

  dispatch_event: function(evt_name, evt_data) {
    var callbacks = this._callbacks[evt_name];
    
    if (callbacks) {
      for (var i=0; i < callbacks.length; i++) {
        callbacks[i] (event_data);
      }
    }
  },
  
  onclose: function() {
    this._connected = false;
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
    Poussr.log("Poussr: data ('" + data +"') is not valid JSON.");
    return data;
  }
};

