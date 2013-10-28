# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
FeedSource.create([{name:"Adme.ru", url: "http://www.adme.ru/rss/metabar"}, {name: "Sportbox", url: "http://news.sportbox.ru/taxonomy/term/11731/0/feed"}])
