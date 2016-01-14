# need 'npm install config'
module.exports = (robot) ->
  robot.respond /議事録/i, (res) ->
    text = res.envelope.message.text
    man = pick(exclude(abstract(text, members), members))
    if man == undefined
      res.send "担当者はいません"
    else
      res.send "議事録担当は @#{man} さんです。よろしくお願いいたします。"

config = require('config')
members = config.get('members')

# abstract member from message if match list value
abstract = (message, list) ->
  abstracted = []
  for person in list
    if message.search(person) != -1
      abstracted.push(person)
  abstracted

# exclude someone from list
exclude = (ex_list, list) ->
  for person in ex_list
    list = list.filter (p) -> p != person
  list

# random pick someone
pick = (list) ->
  list[Math.floor(Math.random() * list.length)]

