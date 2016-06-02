$(function(){

  $("#view_trades").click(function(){
    getTrades();
  });

  $("#trades").click(function(e){
    getTrade($(e.target).text());
    // showTrade();
  });
});

function Trade (trade) {
  this.entry = trade.entry;
  this.id = trade.id;
  this.stop = trade.stop;
  this.take_profit = trade.take_profit;
  this.instrument = trade.instrument;
  this.direction = trade.direction;
  this.user_id = trade.user_id;
  this.newsletter_id = trade.newsletter_id;
  this.closed = trade.closed;
  this.profitable = trade.profitable;
  this.created_at = trade.created_at;
  this.updated_at = trade.updated_at;
  this.toUrl = function() {
    return ("<a href='/trades/" +  this.id + "'>" + this.instrument + "</a></br>");
  };
}

function getTrades() {
  $.get("/trades.json", function(data) {
    var hold = "";
    data.trades.forEach(function(trade) {
        var cur = new Trade(trade);
        hold += '<button class="show">' + cur.id + '</button>';
    });
    $('#trades').html(hold);
  });
}

function getTrade(id) {
  $.get("/trades/" + id + ".json", function(data) {
    var cur = new Trade(data.trade);
    $('#trades').html('<button class="show">' + cur.id + '</button>');
  });
}


function showTrade(){
  // var id = $(this).text();
  alert('id');
}
