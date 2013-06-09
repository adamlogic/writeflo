# Writeflo

I started building Writeflo because I wanted a better way to get feedback on the things I was writing, such as important emails and documentation (like this README). Email makes it difficult to see inline changes, and Google Docs was just too heavyweight. I wanted plain text with clean diffs and comments.

I built it as a tool for me, and it was coming along nicely when I discovered [Draft][]. Draft *is* Writeflo. It's like we were simultaneously building the same app, but Draft was much farther along than Writeflo, and it did exactly what I needed. My focus with Writeflo was solving a problem for myself, and now that problem has been solved.

As of May 2013, I've stopped working on Writeflo. I'm leaving the code here and public in case anyone wants to have fun with it. It's still running on [Heroku][] if you want to check it out, but it's not a supported production environment, your data is not safe, etc. If you're looking for a tool to get feedback on your writing, I highly recommend [Draft][].

[Draft]: http://draftin.com
[Heroku]: http://writeflo.herokuapp.com

## Development

### Install

```bash
bundle install --binstubs
rake db:create db:reset
ln -s ~/projects/writeflo ~/.pow/writeflo
```

### Run

Open at http://writeflo.dev
