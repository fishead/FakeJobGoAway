$(document).ready ->
    chrome.storage.sync.get null, (configs)->
        container = $("tbody#items")

        $("td").delegate "button.show-publisher", 'click', ->
            console.log 'why no error'
            siteCode = $(this).attr("data-siteCode")
            console.log siteCode
            config = {}
            config[siteCode] = []
            console.log config
            chrome.storage.sync.set config

        for key, value of configs
            html = "<tr>
                            <td>#{ key }</td>
                            <td>" + value.join(',') + "</td>
                            <td><button class='show-publisher' data-siteCode=#{ key }>Clean All</button></td>
                        </tr>"
            container.html(container.html() + html)
