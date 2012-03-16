This is a [dotjs](http://defunkt.io/dotjs) script to add per-repo event
filtering to GitHub's news feed. It adds a **Filters** drop-down after the
**Watch** button, allowing you to select which events which you're not
interested in. Then those events are removed (on the client-side) from your
feed. It looks something like:

![Screenshot of the Filters drop-down](http://i.imgur.com/eTpKu.png)


### Requirements

* [dotjs](http://defunkt.io/dotjs)
* [coffeescript](http://coffeescript.org)


### Installation

```bash
$ git clone https://adammck@github.com/adammck/fix-github-news-feed.git
$ cd fix-github-news-feed
$ script/bootstrap
$ script/build
```

### License

[fix-github-news-feed](https://github.com/adammck/fix-github-news-feed) is free
software, available under the MIT license.