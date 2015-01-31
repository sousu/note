# -*- encoding: UTF-8 -*- 
# 
require 'uri'

module Jekyll
  class Post

    EDITED_MATCHER = /^(.+\/)*(\d{6}) - (.*)(\.[^.]+)$/

    def self.valid?(name)
      name =~ EDITED_MATCHER
    end

    def process(name)
      m, cats, date, slug, ext = *name.match(EDITED_MATCHER)
      self.categories = (URI.escape(cats)).split('/')
      self.date = Utils.parse_date(date, "Post '#{relative_path}' does not have a valid date in the filename.")
      self.slug = slug
      self.ext = ext
    end
    
    def url_placeholders
      {
        :year        => date.strftime("%Y"),
        :month       => date.strftime("%m"),
        :day         => date.strftime("%d"),
        :title       => (data['permalink'] || URI.escape(slug)),
        :i_day       => date.strftime("%-d"),
        :i_month     => date.strftime("%-m"),
        :categories  => (categories || []).map { |c| c.to_s }.join('/'),
        :short_month => date.strftime("%b"),
        :short_year  => date.strftime("%y"),
        :y_day       => date.strftime("%j"),
        :output_ext  => output_ext
      }
    end
    def permalink
      # Do nothing
    end
	end
end

