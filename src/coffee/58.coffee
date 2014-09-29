siteCode = 'com58'
publisherSelector = "dl[logr]:contains(publisher)"
parentSelector = "dd.w271"
linkSelector = "a.fl"


# toggle fade when publishers changed
chrome.storage.onChanged.addListener (changes, areaName) ->
    onPublishersChange(siteCode, changes, publisherSelector)

$(document).ready ->
    onPageLoad(siteCode, publisherSelector, parentSelector, linkSelector)
