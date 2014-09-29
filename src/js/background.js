(function() {
  var addPublisher, defaultConfig, getPublishers, removePublisher, savePublishers, togglePublisher,
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  defaultConfig = {
    'com58': ['重庆达内软件有限公司南坪分公司', '重庆汉昌文化产业集团有限公司', '重庆市九龙坡区达内职业培训学校', '北京中关村软件园人才基地'],
    'comganji': ['234234234', '460ljoeuoseu']
  };

  getPublishers = function(siteCode, callback) {
    return chrome.storage.sync.get(siteCode, callback);
  };

  savePublishers = function(config, callback) {
    return chrome.storage.sync.set(config, callback);
  };

  addPublisher = function(siteCode, publisher) {
    return chrome.storage.sync.get(siteCode, function(config) {
      if (__indexOf.call(config[siteCode], publisher) < 0) {
        config[siteCode].push(publisher);
      }
      return savePublishers(config, function() {
        return console.log("add publisher: " + publisher);
      });
    });
  };

  removePublisher = function(siteCode, publisher) {
    return chrome.storage.sync.get(siteCode, function(config) {
      var index;
      index = config[siteCode].indexOf(publisher);
      if (index >= 0) {
        config[siteCode].splice(index, 1);
        return savePublishers(config, function() {
          return console.log("remove publisher: " + publisher);
        });
      }
    });
  };

  togglePublisher = function(siteCode, publisher) {
    return chrome.storage.sync.get(siteCode, function(config) {
      var index;
      index = config[siteCode].indexOf(publisher);
      if (index < 0) {
        return addPublisher(siteCode, publisher, function() {});
      } else {
        return removePublisher(siteCode, publisher, function() {});
      }
    });
  };

  chrome.runtime.onInstalled.addListener(function(details) {
    if (details.reason === 'install') {
      return chrome.storage.sync.set(defaultConfig, function() {
        return console.log('default config imported');
      });
    }
  });

  chrome.runtime.onMessage.addListener(function(message, sender, sendRespons) {
    if (message["do"] === 'get') {
      chrome.storage.sync.get(message.siteCode, function(config) {
        return sendRespons(config);
      });
      return true;
    } else if (message["do"] === 'add') {
      return addPublisher(message.siteCode, message.publisher);
    } else if (message["do"] === 'remove') {
      return removePublisher(message.siteCode, message.publisher);
    } else if (message["do"] === 'toggle') {
      return togglePublisher(message.siteCode, message.publisher);
    }
  });

}).call(this);
