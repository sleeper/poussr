describe("New Poussr object", function() {

  it("should remember correctly parameters",function() {
    var h = "here";
    var p = 12345;
    var c = "mychannel";

    var poussr = new Poussr(h, p, c);

    expect(poussr.host()).toEqual(h);
    expect(poussr.channel_name()).toEqual(c);
    expect(poussr.port()).toEqual(p);
  });

  it("should not be connected",function() {
    var poussr = new Poussr("here", 12345, "mychannel");
    expect(poussr.connected()).toEqual(false);
  });

  it("should have no subscribers", function() {});

});
