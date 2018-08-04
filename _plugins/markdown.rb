# -*- encoding: UTF-8 -*- 

require "cgi"

module Jekyll
  module Converters
    class Markdown
      class RedcarpetParser
        module CommonMethods
          def add_code_tags(code, lang)
            code = code.to_s
            code = code.sub(/<pre>/, "<pre><code class=\"language-#{lang}\" data-lang=\"#{lang}\">")
            code = code.sub(/<\/pre>/,"</code></pre>")
          end

          def link(link, title, alt_text)
            "<a href=\"#{CGI::escapeHTML(link)}\" target=\"_blank\">#{alt_text}</a>"
          end
        end
      end
    end
  end
end

