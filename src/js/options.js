(function() {
  $(document).ready(function() {
    return chrome.storage.sync.get(null, function(configs) {
      var container, html, key, value, _results;
      container = $("tbody#items");
      $("td").delegate("button.show-publisher", 'click', function() {
        var config, siteCode;
        console.log('why no error');
        siteCode = $(this).attr("data-siteCode");
        console.log(siteCode);
        config = {};
        config[siteCode] = [];
        console.log(config);
        return chrome.storage.sync.set(config);
      });
      _results = [];
      for (key in configs) {
        value = configs[key];
        html = ("<tr> <td>" + key + "</td> <td>") + value.join(',') + ("</td> <td><button class='show-publisher' data-siteCode=" + key + ">Clean All</button></td> </tr>");
        _results.push(container.html(container.html() + html));
      }
      return _results;
    });
  });

}).call(this);
