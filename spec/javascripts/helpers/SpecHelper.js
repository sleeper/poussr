beforeEach(function() {
  this.addMatchers({
    toBeEmpty: function() { for(var i in this) { return false; } return true;}
  })
});
