require 'cinch'
require 'httparty'
require 'gist'

module Cinch
    module Plugins
        class EvalSo
            include Cinch::Plugin, HTTParty

            base_uri 'eval.so'
            format :json

            match /eval ([\S]+) (.+)/, method: :eval
            match /langs/, method: :langs

            # Initializes the class and caches a list of languages from teh eval.so API
            def initialize(*args)
                super
                @langs = self.class.get('/api/languages')
            end

            # Print out a list of languages
            # Params:
            # +m+:: +Cinch::Message+ object
            def langs(m)
                m.reply 'Available languages: ' + @langs.keys.join(', ')
            end
            
            # Evaluate code using the eval.so API
            # Params:
            # +m+:: +Cinch::Message+ object
            # +lang+:: The language for code to be evaluated with
            # +code+:: The code to be evaluated
            def eval(m, lang, code)
                options = { :body => {:language => lang, :code => code }.to_json, :headers => { 'Content-Type' => 'application/json' }}
                res = self.class.post('/api/evaluate', options)
                # Eval.so brought back an error, print it out and return
                if res.has_key? 'error'
                    m.reply 'Error: ' + res['error'], true
                    return
                end

                # Print stderr if stdout is empty
                if res['stdout'].empty?
                   output = res['stderr']
                else
                   output = res['stdout']
                end

                # According to RFC 2812, the maximum line length on IRC is 510 characters, minus the carriage return
                # In order to not spam the channel, if the output is greater than one line, convert it to a gist
                if output.length > 510
                    m.reply Gist.gist(output, filename: 'result', description: code)['html_url'], true
                else
                    m.reply output, true
                end
            end
        end
    end
end
