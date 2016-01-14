module.exports = (robot) ->
  #robot.hear /.*/i, (res) ->
  robot.respond /.*/i, (res) ->
    text = res.envelope.message.text
    @exec = require('child_process').exec
    #command = "sh say #{res}"
    command = "sh -c 'say #{text}'"
    @exec command, (err, stdout, stderr) ->
      res.send "mac is speaking now."
    

