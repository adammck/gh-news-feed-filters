This is a Chrome extension to add per-repo event filtering to GitHub's news
feed. It adds a **Filters** drop-down after the **Watch** button, allowing you
to select which events which you're not interested in. Then those events are
removed (on the client-side) from your feed. It looks something like:

![Screenshot of the Filters drop-down](http://i.imgur.com/eTpKu.png)

### Installation

Just click to
[download the extension](https://github.com/downloads/adammck/fix-github-news-feed/fix-github-news-feed.crx)
in Chrome. It's not on the web store (yet).


### Development Requirements

* [coffeescript](http://coffeescript.org)
* [scss](http://sass-lang.com)


### Building

```bash
$ git clone https://github.com/adammck/fix-github-news-feed.git
$ cd fix-github-news-feed
$ script/build
$ script/chrome
```

### License

[fix-github-news-feed](https://github.com/adammck/fix-github-news-feed) is free
software, available under the MIT license.
