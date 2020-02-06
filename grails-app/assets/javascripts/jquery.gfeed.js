/**
 *  Google feed plugin to show rss
 */

if (document.getElementById("divRss")) {
    google.load("feeds", "1");

    function initialize() {
        var feed = new google.feeds.Feed("https://valueme.lalius.com/forum/noticias/index.xml");
        feed.setNumEntries(2);
        feed.load(function(result) {
            if (!result.error) {
                var container = document.getElementById("divRss");
                for (var i = 0; i < result.feed.entries.length; i++) {
                    var entry = result.feed.entries[i];
                    var link = document.createElement("a");
                    $(link).attr("title",entry.title).attr("href",entry.link).text(entry.title +' - ' + new Date(entry.publishedDate).toLocaleString()).attr("target","_blank");   
                    $(link).append(entry.content.substring(0, 75)+ "...")
                    $(link).append('<div class="ui divider"></div>')
                    container.appendChild(link);
                }
            }
        });
    }
    google.setOnLoadCallback(initialize);
}
