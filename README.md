# pyvo_bot

A bot 🤖 reminding people that the [Pyvo](https://pyvo.cz) meetup 🍻 is coming.
Also [@honzajavorek](https://github.com/honzajavorek)'s first real [project](https://en.wikipedia.org/wiki/Project-based_learning) written in Haskell.

## Usage

Currently the bot supports only [Telegram](https://telegram.org/) and can be found at https://t.me/pyvo_bot. The bot runs once per day here using the [CircleCI build](https://circleci.com/gh/honzajavorek/pyvo_bot). It loads iCalendar feed of Pyvo Praha and checks when is the next meetup. If it's about to be soon, it notifies the https://t.me/pyvopraha Telegram channel.

## Development

The project uses [Stack](https://docs.haskellstack.org/). Initial setup:

```
$ git clone git@github.com:honzajavorek/pyvo_bot.git
$ cd pyvo_bot
$ stack setup
```

Building:

```
$ stack build --fast
```

Running:

```
$ TELEGRAM_API_KEY=... \
    TELEGRAM_CHAT_ID... \
    stack --no-nix-pure exec pyvo_bot 'https://pyvo.cz/api/series/praha-pyvo.ics'
```

You can get the chat ID by [adding the bot to a conversation](https://stackoverflow.com/a/33497769), then writing something there so it gets updated with a message, and then GETting `https://api.telegram.org/bot<api_key>/getUpdates` (see [this](https://medium.com/@ManHay_Hong/how-to-create-a-telegram-bot-and-send-messages-with-python-4cf314d9fa3e)).

## To Do

- nicer code
- error/maybe handling
- unit tests
- support & create Telegram channels for Pyvo meetups in other Czech towns
- support Slack

## Credits

Inspired by [ikvasnica/bude-hezky](https://github.com/ikvasnica/bude-hezky), my friend's first real project written in Python.

## License

[MIT](LICENSE)
