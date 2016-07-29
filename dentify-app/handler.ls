_ = require 'lodash'


removeElement = (array, elem) ->
  array = _.remove array, (e) ->
    e is elem

module.exports =
  handleJson: (json, username, shareDb) ->
    if not json.command?
      return {success: false, error: 'Command field not found in json'}
    command = json.command
    if shareDb.users[username]?
      return { success: false, error: 'Username: ' + username + ' not found'}
    switch command
    case 'OPENDOOR'
      if not json.room?
        return {success: false, error: 'Please provide a room number'}
      if not shareDb.users[username]?
        return {success: false, error: 'Username is not in our database'}
      if json.room is shareDb.users[username].room
        return {success: true}
      return {success: false, error: 'Room number is incorrect'}
    case 'CHECKIN'
      if not _.includes shareDb.reservations, username
        {success: false, error: 'reservation for: ' + username + ' not found'}
      else if shareDb.unoccupiedRooms is []
        {success: false, error: 'No available rooms'}
      else if shareDb.users[username].room?
        {success: false, error: username + ' already checked in!'}
      else
        selectedRoom = shareDb.unoccupiedRooms.pop()
        removeElement(shareDb.reservations, username)
        shareDb.occupiedRooms.push(selectedRoom)
        shareDb.users[username].room = selectedRoom
        console.log shareDb
        {success: true, room: selectedRoom}
    default
      {success: false, error: "Command '" + command + "' not supported!"}
