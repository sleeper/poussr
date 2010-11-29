describe("New Poussr object", function() {
  var host = "here";
  var port = 12345;
  var channel = "mychannel";
  var poussr;

  beforeEach(function () {
    poussr = new Poussr(host, port, channel);
  });

  it("should remember correctly parameters",function() {

    expect(poussr.host()).toEqual(host);
    expect(poussr.channel_name()).toEqual(channel);
    expect(poussr.port()).toEqual(port);
  });

  it("should not be connected",function() {
    expect(poussr.connected()).toEqual(false);
  });
});


describe("Connected Poussr object", function() {
  var host = "here";
  var port = 12345;
  var channel = "mychannel";
  var poussr;

  beforeEach(function () {
    poussr = new Poussr(host, port, channel);
  });

  it("should be connected",function() {
    spyOn(window, 'WebSocket').andReturn({});
    poussr.connect();
    expect(poussr.connected()).toBeTruthy();
  });
});


describe("Connected Poussr object", function() {
  var host = "here";
  var port = 12345;
  var channel = "mychannel";
  var poussr;

  beforeEach(function () {
    poussr = new Poussr(host, port, channel);
    spyOn(window, 'WebSocket').andReturn({});
    poussr.connect();
  });

  it("On open, should send a subscribe event to Poussr",function() {
    spyOn(poussr, 'send_event');
    poussr.onopen();
    expect(poussr.send_event).toHaveBeenCalledWith('poussr:subscribe', JSON.stringify({'channel': channel}));
  });

  it("On close, should deconnect",function() {
    poussr.onclose();
    expect(poussr.connected()).toBeFalsy();
  });

  it("On message, should dispatch event", function() {
    var data = {'foo': true};
    var evt = {'channel': channel, 'event': 'foo', 'data': JSON.stringify(data)};
    var ws_evt = {'data': JSON.stringify(evt)};
    spyOn(poussr, 'dispatch_event');
    poussr.onmessage(ws_evt);

    expect(poussr.dispatch_event).toHaveBeenCalledWith('foo', data);
    
  });

});
