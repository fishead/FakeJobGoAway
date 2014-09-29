siteCode = 'comganji'
opacity = 0.1

fadeIn = (publishers) ->
    for publisher in publishers
        $("dl:contains(#{ publisher })").fadeTo "fast", opacity

fadeOut = (publishers) ->
    for publisher in publishers
        $("dl:contains(#{ publisher })").fadeTo 'fast', 1

fadeToggle = (oldPublishers, newPublishers) ->
    fadeInPublishers = (publisher for publisher in newValue when publisher not in oldValue)
    fadeOutPublishers = (publisher for publisher in oldValue when publisher not in newValue)

    fadeOut fadeOutPublishers
    fadeIn fadeInPublishers

# toggle fade when publishers changed
chrome.storage.onChanged.addListener (changes, areaName) ->
    fadeToggle changes[siteCode].oldValue, changes[siteCode].newValue

$(document).ready ->
    $('dd[class=w271]').delegate 'span.hide-publisher', 'click', ->
        publisher = $(this).attr('data-publisher')
        chrome.runtime.sendMessage {do: 'toggle', siteCode: siteCode, publisher: publisher}, (response)->

    $("a[class=fl]", "dd[class=w271]").each ->
        html = "<span class='hide-publisher' style='border: 1px solid #000; pointer: hand;' data-publisher=" + $(this).text() + ">切换显示</span>"
        $(this).after(html)

    # fade in when page loaded
    chrome.runtime.sendMessage {do: 'get', siteCode: siteCode}, (response) ->
        fadeIn response[siteCode]

