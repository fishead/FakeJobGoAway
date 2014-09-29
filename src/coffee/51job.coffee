siteCode = 'com51job'
publisherSelector = "tr.tr0:contains(publisher)"
parentSelector = "td.td2"
linkSelector = "a"

getPublisherName = (element) ->
    element.text()

# toggle fade when publishers changed
chrome.storage.onChanged.addListener (changes, areaName) ->
    onPublishersChange(siteCode, changes, publisherSelector)

$(document).ready ->
    onPageLoad(siteCode, publisherSelector, parentSelector, linkSelector)
