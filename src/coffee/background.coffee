regexFakeSites = new RegExp "https?://(.*\.)?(58.com)/.*"

chrome.tabs.onUpdated.addListener (tabId, changeInfo, tab) -> 
    if regexFakeSites.test tab.url
        chrome.pageAction.show tabId
