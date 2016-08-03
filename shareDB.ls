EventEmitter = require 'event-emitter'


module.exports =
  eventEmitter: new EventEmitter
  rooms: [
    {
      roomNo: 0
      status: 'booked'
      user: 'gnuclient'
    },
    {
      roomNo: 1
      status: 'booked'
      user: 'Gerald Ford'
    },
    {
      roomNo: 2
      status: 'available'
    },
    {
      roomNo: 3
      status: 'available'
    },
    {
      roomNo: 4
      status: 'booked'
      user: 'celene dion'
    },
    {
      roomNo: 5
      status: 'checked-in'
      user: 'Kevin Goslar'
    },
    {
      roomNo: 6
      status: 'checked-in'
      user: 'Kevin Goslar'
    },
    {
      roomNo: 7
      status: 'checked-in'
      user: 'Kevin Goslar'
    }
  ]
