
module.exports =
  handleJson: (json, username, shareDb) ->
    if not json.command?
      return {success: false, error: 'Command field not found in json'}
    command = json.command
    switch command
    case 'OPENDOOR'
      if not json.room?
        return {success: false, error: 'Please provide a room number'}
      if not shareDb.users[username]?
        return {success: false, error: 'Username is not in our database'}
      if json.room is shareDb.users[username].room
        return {success: true}
      return {success: false, error: 'Room number is incorrect'}
    default
      {success: false, error: "Command '" + command + "' not supported!"}
