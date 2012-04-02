This is a Chrome extension to add per-repo alert filtering to GitHub. It
supplements the existing **Watch** button by adding an **Alerts** drop-down,
allowing you to uncheck alerts to filter them (on the client-side) from your
news feed. It looks something like:

![Screenshots of the GitHub News Feed Filters] [screenshots]


### Installation

Just click to [download the extension] [download] in Chrome. It's not on the
[Chrome Web Store] [webstore] yet.


### Building

If you want to hack on this thing, you'll have to build it locally, and add the
`ext` directory as an "unpacked extension" in Chrome. You'll need [coffeescript]
[coffee] and [scss] [scss].

```bash
$ git clone git://github.com/adammck/gh-news-feed-filters.git
$ cd gh-news-feed-filters
$ script/build
```

To build an actual `.crx` extension:

```bash
$ script/chrome
```

### License

[GitHub News Feed Filters] [repo] is free software, available under [the MIT
license] [license].




[repo]:        https://github.com/adammck/gh-news-feed-filters
[license]:     https://raw.github.com/adammck/gh-news-feed-filters/master/LICENSE
[download]:    https://github.com/downloads/adammck/gh-news-feed-filters/gh-news-feed-filters.crx
[screenshots]: http://i.imgur.com/jAOjo.png
[webstore]:    https://chrome.google.com/webstore
[coffee]:      http://coffeescript.org
[scss]:        http://sass-lang.com
