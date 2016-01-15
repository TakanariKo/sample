# need 'npm install config js-yaml'
# make config directory and default.yaml
# add member list in default.yaml. Like below
# members:
#  - foo
#  - bar

module.exports = (robot) ->
  robot.respond /議事録/i, (res) ->
    text = res.envelope.message.text
    man = pick(exclude(abstract(text, members), members))
    if man == undefined
      resText = "担当者はいません" 
    else
      resText = "議事録担当は @#{man} さんです。よろしくお願いいたします。"
    @exec = require('child_process').exec
    command = "sh -c 'say #{resText}'"
    @exec command, (err, stdout, stderr) ->
      return

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
  i = Math.floor(Math.random() * (list.length))
  if i >= 0 && i < list.length
    list[i]
  else
    undefined

