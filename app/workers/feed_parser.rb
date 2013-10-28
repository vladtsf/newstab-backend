require 'rss'

class FeedParser < ApplicationController
  include Sidekiq::Worker
  sidekiq_options queue: "feed", retry: false

  def perform(source_id)
    source = FeedSource.find(source_id)

    RSS::Parser.parse(open('http://news.sportbox.ru/taxonomy/term/11731/0/feed').read, false).items.each do |item|
      PostParser.perform_async source_id, item.link
    end
  end
end