defaultConfig = {
    'com58': [
        '重庆达内软件有限公司南坪分公司',
        '重庆汉昌文化产业集团有限公司',
        '重庆市九龙坡区达内职业培训学校',
        '北京中关村软件园人才基地'
    ],
    'comganji': [
        '234234234',
        '460ljoeuoseu'
    ]
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

# chrome.storage.sync.clear() # for test

chrome.runtime.onInstalled.addListener (details) ->
    if details.reason is 'install'
        chrome.storage.sync.set defaultConfig, ->
            console.log 'default comfig imported'


chrome.runtime.onMessage.addListener (message, sender, sendRespons) ->
    if message.do is 'get'
        chrome.storage.sync.get message.siteCode, (config) ->
            sendRespons config
        return true

    else if message.do is 'add'
        addPublisher message.siteCode, message.publisher

    else if message.do is 'remove'
        removePublisher message.siteCode, message.publisher