## Newstab

### Requirements
* Postgresql
* Redis
* libxml2
* libxslt
* ImageMagick

### Installation
`bundle install`
`rake db:create db:migrate db:seed`

### Run
`rails s`

### Queue
`sidekiq -c 5 --verbose -q feed,post`

### Scheduler
`whenever`

### API

#### Feed
  *GET* /feed.json
  ```json
[
  {
    "id": 477,
    "image": {
      "src": "http://s.s-ports.ru/sites/default/files/imagecache/medium-photos/2013-10-07T111521Z_33419618_GM1E9A71HCX01_RTRMADP_3_OLYMPICS-SOCHI-FLAME_0.JPG",
      "width": 320,
      "height": 211
    },
    "title": "Сочи-2014. В добрый путь!",
    "href": "http://news.sportbox.ru/Vidy_sporta/Events/Sochi2014/Olympicflame/spbfoto_NI407636_V-dobriy-puti",
    "source": "Sportbox"
  }
]
  ```