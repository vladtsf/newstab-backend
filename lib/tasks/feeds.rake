namespace :feeds do
  task :parse => :environment do
    FeedSource.all.each do |source|
      Resque.enqueue FeedParser, source.id
    end
  end
end