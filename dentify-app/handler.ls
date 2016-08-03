_ = require 'lodash'


findRoom = (rooms, username) ->
  _.find rooms, (room) ->
    return room.user is username

module.exports =
  handleJson: (json, username, shareDb) ->
    if not json.command?
      return {success: false, error: 'Command field not found in json'}
    command = json.command

    switch command

    case 'OPENDOOR'
      if not json.room?
        return {success: false, error: 'Please provide a room number'}
      userRoom = findRoom shareDb.rooms, username
      if not userRoom? or userRoom.status isnt 'checked-in'
        return {success: false, error: 'User is not checked in'}
      if userRoom.roomNo isnt json.room
        return {success: false, error: 'Room number is incorrect'}
      return {success: true}

    case 'CHECKIN'
      userRoom = findRoom shareDb.rooms, username
      if not userRoom?
        return {success: false, error: 'reservation for: ' + username + ' not found'}
      else if userRoom.status isnt 'booked'
        return {success: false, error: username + ' already checked in!'}
      else
        userRoom.status = 'checked-in'
        shareDb.eventEmitter.emit 'update', shareDb
        return {success: true, room: userRoom.roomNo}

    case 'ROOMCHARGE'
      userRoom = findRoom shareDb.rooms, username
      if not userRoom? or userRoom.status isnt 'checked-in'
        return {success: false, error: username + ' is not checked in!'}
      if not json.amount?
        return {success: false, error: 'Charge amount was not provided'}
      if not userRoom.amount?
        baseAmount = 0
      else
        baseAmount = userRoom.amount
      userRoom.amount = baseAmount + json.amount
      shareDb.eventEmitter.emit 'update', shareDb
      return {success: true, amount: userRoom.amount}

    case 'CHECKOUT'
      userRoom = findRoom shareDb.rooms, username
      if not userRoom? or userRoom.status isnt 'checked-in'
        return { success: false, error: 'User isn\'t checked in!'}
      payAmount = if userRoom.amount? then userRoom.amount else 0
      retJson = { success: true, amount: payAmount}
      userRoom.status = 'available'
      delete userRoom.user
      delete userRoom.amount if userRoom.amount?
      shareDb.eventEmitter.emit 'update', shareDb
      return retJson

    default
      {success: false, error: "Command '" + command + "' not supported!"}
