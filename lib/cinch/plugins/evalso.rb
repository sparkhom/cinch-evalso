require 'cinch'
require 'evalso'

module Cinch
  module Plugins
    class EvalSo
      include Cinch::Plugin

      match /eval ([\S]+) (.+)/, method: :eval
      match /langs/, method: :langs

      # Print out a list of languages
      # Params:
      # +m+:: +Cinch::Message+ object
      def langs(m)
        m.reply "Available languages: #{Evalso.languages.keys.join(', ')}"
      end
      
      # Evaluate code using the eval.so API
      # Params:
      # +m+:: +Cinch::Message+ object
      # +lang+:: The language for code to be evaluated with
      # +code+:: The code to be evaluated
      def eval(m, lang, code)
        res = Evalso.run(language: lang, code: code)

        # Default to stdout, fall back to stderr.
        output = res.stdout
        output = res.stderr if output.empty?

        output = output.gsub(/\n/,' ')

        # According to RFC 2812, the maximum line length on IRC is 510 characters, minus the carriage return
        # In order to not spam the channel, if the output is greater than one line, convert it to a gist
        if output.length > 510
          output = Gist.gist(output, filename: 'result', description: code)['html_url']
        end

        m.reply output, true
      rescue Evalso::HTTPError => e
        # Eval.so returned an error, pass it on to IRC.
        m.reply "Error: #{e.message}", true
      end
    end
  end
end
