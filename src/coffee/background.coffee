chrome.storage.sync.clear() # for test

defaultConfig = {
    'com58': [
        '重庆达内软件有限公司南坪分公司',
        '重庆汉昌文化产业集团有限公司',
        '重庆市九龙坡区达内职业培训学校',
        '北京中关村软件园人才基地'
    ],
    'comganji': []
}

getPublishers = (siteCode, callback) ->
    chrome.storage.sync.get siteCode, callback

savePublishers = (config, callback) ->
    chrome.storage.sync.set config, callback

addPublisher = (siteCode, publisher) ->
    chrome.storage.sync.get siteCode, (config) ->
        config[siteCode].push publisher if publisher not in config[siteCode]
        savePublishers config, ->
            console.log "add publisher: #{ publisher }"

removePublisher = (siteCode, publisher) ->
    chrome.storage.sync.get siteCode, (config) ->
        index = config[siteCode].indexOf publisher
        if index >= 0    
            config[siteCode].splice index, 1
            savePublishers config, ->
                console.log "remove publisher: #{ publisher }"

togglePublisher = (siteCode, publisher) ->
    chrome.storage.sync.get siteCode, (config) ->
        index = config[siteCode].indexOf publisher
        if index < 0
            addPublisher siteCode, publisher, ->
        else
            removePublisher siteCode, publisher, ->

# import default config when extension installed
chrome.runtime.onInstalled.addListener (details) ->
    if details.reason is 'install'
        chrome.storage.sync.set defaultConfig, ->
            console.log 'default config imported'

# handle message from content script
chrome.runtime.onMessage.addListener (message, sender, sendRespons) ->
    if message.do is 'get'
        chrome.storage.sync.get message.siteCode, (config) ->
            if 'siteCode' not in config
                config[message.siteCode] = []
                savePublishers config, ->
                    console.log "init empty publishers on: #{ config }"
                    console.log config
                    return true
            sendRespons config
        return true

    else if message.do is 'add'
        addPublisher message.siteCode, message.publisher

    else if message.do is 'remove'
        removePublisher message.siteCode, message.publisher

    else if message.do is 'toggle'
        togglePublisher message.siteCode, message.publisher
