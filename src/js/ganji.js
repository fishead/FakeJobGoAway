(function() {
  var addToggle, fadeIn, fadeOut, fadeToggle, linkSelector, onPageLoad, onPublishersChange, opacity, parentSelector, publisherSelector, siteCode,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  siteCode = 'comganji';

  publisherSelector = "dl.job-list:contains(publisher)";

  parentSelector = "dd.company";

  linkSelector = "a[title]";

  chrome.storage.onChanged.addListener(function(changes, areaName) {
    return onPublishersChange(siteCode, changes, publisherSelector);
  });

  $(document).ready(function() {
    return onPageLoad(siteCode, publisherSelector, parentSelector, linkSelector);
  });

  opacity = 0.1;

  addToggle = function(parentSelector, linkSelector) {
    $(parentSelector).delegate('span.toggle-publisher', 'click', function() {
      var publisher;
      publisher = $(this).attr('data-publisher');
      return chrome.runtime.sendMessage({
        "do": 'toggle',
        siteCode: siteCode,
        publisher: publisher
      }, function(response) {});
    });
    return $(linkSelector, parentSelector).each(function() {
      var html, toggleButton;
      toggleButton = "<span class='toggle-publisher' style='border: 1px solid #000; pointer: hand;' data-publisher='publisher-name' >切换显示</span>";
      html = toggleButton.replace('publisher-name', $(this).attr('title'));
      return $(this).after(html);
    });
  };

  fadeIn = function(publishers, publisherSelector) {
    var publisher, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = publishers.length; _i < _len; _i++) {
      publisher = publishers[_i];
      _results.push($(publisherSelector.replace('publisher', publisher)).fadeTo("fast", opacity));
    }
    return _results;
  };

  fadeOut = function(publishers, publisherSelector) {
    var publisher, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = publishers.length; _i < _len; _i++) {
      publisher = publishers[_i];
      _results.push($(publisherSelector.replace('publisher', publisher)).fadeTo('fast', 1));
    }
    return _results;
  };

  fadeToggle = function(oldPublishers, newPublishers, publisherSelector) {
    var fadeInPublishers, fadeOutPublishers, publisher;
    fadeInPublishers = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = newPublishers.length; _i < _len; _i++) {
        publisher = newPublishers[_i];
        if (__indexOf.call(oldPublishers, publisher) < 0) {
          _results.push(publisher);
        }
      }
      return _results;
    })();
    fadeOutPublishers = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = oldPublishers.length; _i < _len; _i++) {
        publisher = oldPublishers[_i];
        if (__indexOf.call(newPublishers, publisher) < 0) {
          _results.push(publisher);
        }
      }
      return _results;
    })();
    fadeOut(fadeOutPublishers, publisherSelector);
    return fadeIn(fadeInPublishers, publisherSelector);
  };

  onPageLoad = function(siteCode, publisherSelector, parentSelector, linkSelector) {
    addToggle(parentSelector, linkSelector);
    return chrome.runtime.sendMessage({
      "do": 'get',
      siteCode: siteCode
    }, function(response) {
      return fadeIn(response[siteCode], publisherSelector);
    });
  };

  onPublishersChange = function(siteCode, changes, publisherSelector) {
    var newPublishers, oldPublishers;
    console.log('publishers changed');
    console.log(changes);
    if (changes[siteCode]) {
      oldPublishers = changes[siteCode]['oldValue'] || [];
      newPublishers = changes[siteCode]['newValue'] || [];
      return fadeToggle(oldPublishers, newPublishers, publisherSelector);
    }
  };

}).call(this);
