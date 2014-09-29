siteCode = 'comganji'
publisherSelector = "dl.job-list:contains(publisher)"
parentSelector = "dd.company"
linkSelector = "a[title]"

getPublisherName = (element) ->
    element.attr('title')

# toggle fade when publishers changed
chrome.storage.onChanged.addListener (changes, areaName) ->
    onPublishersChange(siteCode, changes, publisherSelector)

$(document).ready ->
    onPageLoad(siteCode, publisherSelector, parentSelector, linkSelector, getPublisherName)
