namespace :images do
  task :links => :environment do
    File.write "tmp/pids/images.json", Post.all.map { |post| {:image_src => post.image_src.url, :id => post.id} }.to_json
  end

  task :reload => :environment do
    @images = JSON.parse File.read 'tmp/pids/images.json'

    @images.each do |image|
      post = Post.find(image['id'])
      post.image_src = image['image_src']
      post.save
    end
  end
end