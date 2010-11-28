describe("New Poussr object", function() {

  it("should remember correctly parameters",function() {
    var h = "here";
    var p = 12345;
    var c = "mychannel";

    var p = new Poussr(h, p, c);

    expect(p.host()).toEqual(h);
    expect(p.port()).toEqual(p);
    expect(p.channel()).toEqual(c);
  });

  it("should not be connected",function() {
    var p = new Poussr("here", 12345, "mychannel");
    expect(p.connected()).toEqual(false);
  });

  it("should have no subscribers", function() {});

});
