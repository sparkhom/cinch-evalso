# cinch-evalso

The Cinch eval.so plugin. Send requests to the eval.so API for processing.

## Installation

Install the gem

```
gem install cinch-evalso
```

## Example

```ruby
require 'cinch'
require 'cinch/plugins/evalso'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.org"
    c.channels = ["#cinch-bots"]
    c.plugin.plugins = [Cinch::Plugins::EvalSo]
  end
end

bot.start
```

## Usage

```!langs``` Prints out a list of the languages available from the eval.so API

```!eval {language} {code}``` Evaluates code using the eval.so API

## License

This plugin is licensed under the [MIT License](http://opensource.org/licenses/MIT).
