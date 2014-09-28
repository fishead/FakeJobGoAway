siteCode = 'com58'

hidePublishers = (publishers)->
    for publisher in publishers
        $("dl:contains(#{ publisher })").hide()

showPublishers = (publishers)->
    for publisher in publishers
        $("dl:contains(#{ publisher })").show()

chrome.storage.onChanged.addListener (changes, areaName) ->
    showPublishers changes[siteCode].oldValue
    hidePublishers changes[siteCode].newValue


$(document).ready ->
    $('dd[class=w271]').delegate 'span.hide-publisher', 'click', ->
        publisher = $(this).attr('data-publisher')
        chrome.runtime.sendMessage {do: 'add', siteCode: siteCode, publisher: publisher}, (response)->

    $("a[class=fl]", "dd[class=w271]").each ->
        html = "<span class='hide-publisher' style='border: 1px solid #000; pointer: hand;' data-publisher=" + $(this).text() + ">Hide</span>"
        $(this).after(html)

    chrome.runtime.sendMessage {do: 'get', siteCode: siteCode}, (response) ->
        console.log 'get response'
        console.log response
        hidePublishers response[siteCode]

