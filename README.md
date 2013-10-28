## Newstab

### Requirements
Postgresql
Redis
libxml2
libxslt
ImageMagick

### Installation
`bundle install` then `rake db:create db:migrate db:seed`

### Run
rails s

### Queue
`sidekiq -c 5 --verbose -q feed,post`

### Scheduler
`whenever`