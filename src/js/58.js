(function() {
  var hidePublishers, showPublishers, siteCode;

  siteCode = 'com58';

  hidePublishers = function(publishers) {
    var publisher, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = publishers.length; _i < _len; _i++) {
      publisher = publishers[_i];
      _results.push($("dl:contains(" + publisher + ")").hide());
    }
    return _results;
  };

  showPublishers = function(publishers) {
    var publisher, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = publishers.length; _i < _len; _i++) {
      publisher = publishers[_i];
      _results.push($("dl:contains(" + publisher + ")").show());
    }
    return _results;
  };

  chrome.storage.onChanged.addListener(function(changes, areaName) {
    showPublishers(changes[siteCode].oldValue);
    return hidePublishers(changes[siteCode].newValue);
  });

  $(document).ready(function() {
    $('dd[class=w271]').delegate('span.hide-publisher', 'click', function() {
      var publisher;
      publisher = $(this).attr('data-publisher');
      return chrome.runtime.sendMessage({
        "do": 'add',
        siteCode: siteCode,
        publisher: publisher
      }, function(response) {});
    });
    $("a[class=fl]", "dd[class=w271]").each(function() {
      var html;
      html = "<span class='hide-publisher' style='border: 1px solid #000; pointer: hand;' data-publisher=" + $(this).text() + ">Hide</span>";
      return $(this).after(html);
    });
    return chrome.runtime.sendMessage({
      "do": 'get',
      siteCode: siteCode
    }, function(response) {
      console.log('get response');
      console.log(response);
      return hidePublishers(response[siteCode]);
    });
  });

}).call(this);
