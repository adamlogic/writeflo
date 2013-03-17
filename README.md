# writeflo

## Development

### Requirements

- pow

### Install

```bash
bundle install --binstubs
rake db:create db:reset
ln -s ~/projects/writeflo ~/.pow/writeflo
```

### Run

Open at http://writeflo.dev

### Live SASS changes

To see live SASS changes in your browser, run `guard -P livereload` in a
terminal or tmux session. Live reload JS is automatically injected into the
document `<head>`, so the websocket connection will show any saved changes
immediately.
