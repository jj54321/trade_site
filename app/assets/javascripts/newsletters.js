$(function(){

  $("#view_trades").click(function(){
    getTrades();
  });

  $("#trades").click(function(e){
    getTrade($(e.target).text());
    // showTrade();
  });

  $('form[id="list_form"]').submit(function(event) {
    event.preventDefault();

    var values = $(this).serialize();
    this.reset();
    var posting = $.post('/list_items', values);

    posting.done(function(data) {
      var cur = new ListItem(data);
      $(".list").append("<li>" + cur.id + ':' + cur.content + '</li>');
    });
  });

  $('#link_hold').click(function(e){
    e.preventDefault();
    getNewsletter();
  });

});

function ListItem (item){
  this.id = item.id;
  this.content = item.content;
}

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
  this.newsletter = trade.newsletter;
  this.toUrl = function() {
    return ("<a  href='/trades/" +  this.id + "'>" + this.created_at + "</a></br>");
  };
  this.newsletterUrl = function(){
    return ("<a id='news_url' href='/users/" +  this.user_id + "/newsletters/" + this.newsletter.id + "'>" + this.newsletter.title + "</a>");
  }
}

function getTrades() {
  $.get("/trades.json", function(data) {
    var hold = "";
    data.trades.forEach(function(trade) {
        var cur = new Trade(trade);
        hold += '<li><button class="show">' + cur.id + '</button>' +  cur.newsletter.title +  '</li>';
    });
    $('#trades').html(hold);
    $('#link_hold').html("");
  });
}

function getTrade(id) {
  $.get("/trades/" + id + ".json", function(data) {
    var cur = new Trade(data.trade);
    $('#trades').html('<li><button class="show">' + cur.id + '</button>' + '</li>');
    $('#link_hold').html(cur.newsletterUrl());
  });
}

function getNewsletter(){
  $.get($('#news_url').attr('href'), function(data) {
    $('#link_hold').html(data);
  });
}
