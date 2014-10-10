siteCode = 'comzhaopin'
publisherSelector = "tr.showTR:contains(publisher)"
parentSelector = "td.Companyname"
linkSelector = "a"

getPublisherName = (element) ->
    element.text()

# toggle fade when publishers changed
chrome.storage.onChanged.addListener (changes, areaName) ->
    onPublishersChange siteCode, changes, publisherSelector

$(document).ready ->
    console.log 'on page load'
    onPageLoad siteCode, publisherSelector, parentSelector, linkSelector
