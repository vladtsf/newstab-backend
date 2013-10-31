## Newstab

### Requirements
* Postgresql
* Redis
* libxml2
* libxslt
* ImageMagick

### Installation
```bash
bundle install
rake db:create db:migrate db:seed
```

### Run
`rails s`

### Queue
`sidekiq -c 5 --verbose -q feed,post`

### Deployment

#### setup environment
`cap deploy:setup`

#### Hands on feeds parse
`cap feeds:parse`

#### reload nginx
`cap nginx:reload`

#### S3
Throw the `s3.yml` to `shared/files/config/`

#### just deploy
`cap deploy`

### API

#### Feed
  *GET* /api/feed?limit=30&offset=0
  ```json
{
  "offset": 0,
  "limit": 30,
  "total": 159,
  "items": [
    {
      "id": 309,
      "image": {
        "src": "http://s3.amazonaws.com/newstab/posts/image_srcs/000/000/309/original/1383241808506.jpg20131031-5507-1haifd7?1383241808",
        "width": 256,
        "height": 168
      },
      "title": "Сочи-2014. Канадцы приедут в Сочи в черно-бело-красном",
      "href": "http://news.sportbox.ru/Vidy_sporta/Events/Sochi2014/spbfoto_NI413035_Kanadci-priedut-v-Sochi-v-cherno-belo-krasnom"
    }
  ]
}
  ```