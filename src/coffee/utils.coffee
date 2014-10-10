opacity = 0.1

addToggle = (parentSelector, linkSelector) ->
    $(parentSelector).delegate 'span.toggle-publisher', 'click', ->
        publisher = $(this).attr('data-publisher')
        chrome.runtime.sendMessage {do: 'toggle', siteCode: siteCode, publisher: publisher}, (response)->

    $(linkSelector, parentSelector).each ->
        toggleButton = "
            <span
                class='toggle-publisher' 
                style='border: 1px solid #000; pointer: hand;'
                data-publisher='publisher-name'
            >切换显示</span>"
        html = toggleButton.replace('publisher-name', getPublisherName($(this)))
        $(this).after(html)

fadeIn = (publishers, publisherSelector) ->
    for publisher in publishers
        $(publisherSelector.replace('publisher', publisher)).fadeTo "fast", opacity

fadeOut = (publishers, publisherSelector) ->
    for publisher in publishers
        $(publisherSelector.replace('publisher', publisher)).fadeTo 'fast', 1

fadeToggle = (oldPublishers, newPublishers, publisherSelector) ->
    fadeInPublishers = (publisher for publisher in newPublishers when publisher not in oldPublishers)
    fadeOutPublishers = (publisher for publisher in oldPublishers when publisher not in newPublishers)

    fadeOut fadeOutPublishers, publisherSelector
    fadeIn fadeInPublishers, publisherSelector

onPageLoad = (siteCode, publisherSelector, parentSelector, linkSelector, getPublisherName) ->
    # add toggle button
    addToggle(parentSelector, linkSelector)

    # fade in when page loaded
    chrome.runtime.sendMessage {do: 'get', siteCode: siteCode}, (response) ->
        fadeIn response[siteCode], publisherSelector

onPublishersChange = (siteCode, changes, publisherSelector) ->
    # console.log 'publishers changed'
    # console.log  changes

    # publishers in site has changed
    if changes[siteCode]
        oldPublishers = changes[siteCode]['oldValue'] or []
        newPublishers = changes[siteCode]['newValue'] or []
        fadeToggle oldPublishers, newPublishers, publisherSelector
