require 'rss'

class FeedParser < ApplicationController
  include Sidekiq::Worker
  sidekiq_options queue: "feed", retry: false

  def perform(source_id)
    source = FeedSource.find(source_id)

    RSS::Parser.parse(open(source.url).read, false).items.each_with_index do |item, idx|
      PostParser.perform_async source_id, idx, item.link
    end
  end
end