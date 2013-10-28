namespace :feeds do
  task :parse => :environment do
    FeedSource.all.each do |source|
      FeedParser.perform_async source.id
    end
  end
end