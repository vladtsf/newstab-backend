require 'rss'

class FeedParser
  @queue = :feed

  def self.perform(source_id)
    source = FeedSource.find(source_id)

    RSS::Parser.parse(open(source.url).read, false).items.each_with_index do |item, idx|
      Resque.enqueue(PostParser, source_id, idx, item.link)
    end
  end
end