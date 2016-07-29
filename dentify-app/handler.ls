_ = require 'lodash'


removeElement = (array, elem) ->
  array = _.remove array, (e) ->
    e is elem

module.exports =
  handleJson: (json, username, shareDb) ->
    if not json.command?
      return {success: false, error: 'Command field not found in json'}
    command = json.command
    if not shareDb.users[username]?
      return { success: false, error: 'Username: ' + username + ' not found'}

    switch command

    case 'OPENDOOR'
      if not json.room?
        return {success: false, error: 'Please provide a room number'}
      if json.room is shareDb.users[username].room
        return {success: true}
      return {success: false, error: 'Room number is incorrect'}

    case 'CHECKIN'
      if not _.includes shareDb.reservations, username
        return {success: false, error: 'reservation for: ' + username + ' not found'}
      else if shareDb.unoccupiedRooms is []
        return {success: false, error: 'No available rooms'}
      else if shareDb.users[username].room?
        return {success: false, error: username + ' already checked in!'}
      else
        selectedRoom = shareDb.unoccupiedRooms.pop()
        removeElement(shareDb.reservations, username)
        shareDb.occupiedRooms.push(selectedRoom)
        shareDb.users[username].room = selectedRoom
        return {success: true, room: selectedRoom}

    case 'ROOMCHARGE'
      if not shareDb.users[username].room?
        return {success: false, error: username + ' is not checked in!'}
      if not json.amount?
        return {success: false, error: 'Charge amount was not provided'}
      if not shareDb.users[username].amount?
        baseAmount = 0
      else
        baseAmount = shareDb.users[username].amount
      shareDb.users[username].amount = baseAmount + json.amount
      return {success: true, amount: shareDb.users[username].amount}
    default
      {success: false, error: "Command '" + command + "' not supported!"}
