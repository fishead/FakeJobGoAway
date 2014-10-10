# domain name remove dot(.) and revert, 58.com = com58
siteCode = 'com58'

# one job item
publisherSelector = "dl[logr]:contains(publisher)"

# parent element contain publisher (or company) name
parentSelector = "dd.w271"

# link of publisher (or company) name
linkSelector = "a.fl"

# function to get the publisher (or company) name
getPublisherName = (element) ->
    element.attr('title')

# toggle fade when publishers changed
chrome.storage.onChanged.addListener (changes, areaName) ->
    onPublishersChange siteCode, changes, publisherSelector

$(document).ready ->
    onPageLoad siteCode, publisherSelector, parentSelector, linkSelector
