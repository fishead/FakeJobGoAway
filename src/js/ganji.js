(function() {
  var fadeIn, fadeOut, fadeToggle, opacity, siteCode,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  siteCode = 'comganji';

  opacity = 0.1;

  fadeIn = function(publishers) {
    var publisher, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = publishers.length; _i < _len; _i++) {
      publisher = publishers[_i];
      _results.push($("dl:contains(" + publisher + ")").fadeTo("fast", opacity));
    }
    return _results;
  };

  fadeOut = function(publishers) {
    var publisher, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = publishers.length; _i < _len; _i++) {
      publisher = publishers[_i];
      _results.push($("dl:contains(" + publisher + ")").fadeTo('fast', 1));
    }
    return _results;
  };

  fadeToggle = function(oldPublishers, newPublishers) {
    var fadeInPublishers, fadeOutPublishers, publisher;
    fadeInPublishers = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = newValue.length; _i < _len; _i++) {
        publisher = newValue[_i];
        if (__indexOf.call(oldValue, publisher) < 0) {
          _results.push(publisher);
        }
      }
      return _results;
    })();
    fadeOutPublishers = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = oldValue.length; _i < _len; _i++) {
        publisher = oldValue[_i];
        if (__indexOf.call(newValue, publisher) < 0) {
          _results.push(publisher);
        }
      }
      return _results;
    })();
    fadeOut(fadeOutPublishers);
    return fadeIn(fadeInPublishers);
  };

  chrome.storage.onChanged.addListener(function(changes, areaName) {
    return fadeToggle(changes[siteCode].oldValue, changes[siteCode].newValue);
  });

  $(document).ready(function() {
    $('dd[class=w271]').delegate('span.hide-publisher', 'click', function() {
      var publisher;
      publisher = $(this).attr('data-publisher');
      return chrome.runtime.sendMessage({
        "do": 'toggle',
        siteCode: siteCode,
        publisher: publisher
      }, function(response) {});
    });
    $("a[class=fl]", "dd[class=w271]").each(function() {
      var html;
      html = "<span class='hide-publisher' style='border: 1px solid #000; pointer: hand;' data-publisher=" + $(this).text() + ">切换显示</span>";
      return $(this).after(html);
    });
    return chrome.runtime.sendMessage({
      "do": 'get',
      siteCode: siteCode
    }, function(response) {
      return fadeIn(response[siteCode]);
    });
  });

}).call(this);
