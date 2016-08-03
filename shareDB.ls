EventEmitter = require 'event-emitter'


module.exports =
  eventEmitter: new EventEmitter
  rooms: [
    {
      roomNo: 0
      status: 'booked'
      user: 'gnuclient'
      w: '200px'
      h: '200px'
    },
    {
      roomNo: 1
      status: 'booked'
      user: 'Gerald Ford'
      w: '200px'
      h: '200px'
    },
    {
      roomNo: 2
      status: 'available'
      w: '200px'
      h: '200px'
    },
    {
      roomNo: 3
      status: 'available'
      w: '200px'
      h: '200px'
    },
    {
      roomNo: 4
      status: 'booked'
      user: 'celene dion'
      w: '200px'
      h: '200px'
    },
    {
      roomNo: 5
      status: 'checked-in'
      user: 'Kevin Goslar'
      w: '200px'
      h: '200px'
    }
  ]
