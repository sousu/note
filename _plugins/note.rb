# -*- encoding: UTF-8 -*- 
# 

module Jekyll
  Jekyll.logger.info "Load sousu/note plugin..."

  class Document
    #DATE_FILENAME_MATCHER = %r!^(?>.+/)*?(\d{2,4}-\d{1,2}-\d{1,2})-([^/]*)(\.[^.]+)$!.freeze
    DATE_FILENAME_MATCHER = %r!^.*?([^/]+)/(\d{8})_([^/]*)(\.[^.]+)$!.freeze

    def populate_title
      if relative_path =~ DATE_FILENAME_MATCHER
        category, date, slug, ext = Regexp.last_match.captures #ディレクトリをカテゴリ化
        #date, slug, ext = Regexp.last_match.captures
        modify_date(date)
      elsif relative_path =~ DATELESS_FILENAME_MATCHER
        slug, ext = Regexp.last_match.captures
      end
      data["categories"] = [category] #ディレクトリをカテゴリ化

      # slugs shouldn't end with a period
      # `String#gsub!` removes all trailing periods (in comparison to `String#chomp!`)
      slug.gsub!(%r!\.*\z!, "")
      # Try to ensure the user gets a title.
      data["title"] ||= Utils.titleize_slug(slug)
      # Only overwrite slug & ext if they aren't specified.
      data["slug"]  ||= slug
      data["ext"]   ||= ext
    end
  end

  class PostReader
    def read_content(dir, magic_dir, matcher)
      @site.reader.get_entries(dir, magic_dir).map do |entry|
        next if entry =~ /old\/.+/ # oldフォルダ取り込み不要
        next unless matcher.match?(entry)
        path = @site.in_source_dir(File.join(dir, magic_dir, entry))
        Document.new(path,
                     :site       => @site,
                     :collection => @site.posts)
      end.reject(&:nil?)
    end
  end

end

