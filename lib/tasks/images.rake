namespace :images do
  task :links => :environment do
    File.write "/tmp/images.json", Post.all.map { |post| {:image_src => post.image_src.url, :id => post.id} }.to_json
  end

  task :reload => :environment do
    @images = JSON.parse File.read '/tmp/images.json'

    @images.each_with_index do |image, index|
      puts "#{index} #{image.id} #{image.image_src}"
      begin
        post = Post.find(image['id'])
        post.image_src = image['image_src']
        post.save
      rescue Exception => e
        puts e.to_s
      end
    end
  end
end