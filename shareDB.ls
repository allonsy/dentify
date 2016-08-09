EventEmitter = require 'event-emitter'


module.exports =
  eventEmitter: new EventEmitter
  floors: [
    {
      floorNo: 1
      rooms: [
        {
          roomNo: 1000
          status: 'booked'
          user: 'androidclient'
        },
        {
          roomNo: 1001
          status: 'booked'
          user: 'Gerald Ford'
        },
        {
          roomNo: 1002
          status: 'available'
        },
        {
          roomNo: 1003
          status: 'available'
        },
        {
          roomNo: 1004
          status: 'booked'
          user: 'celene dion'
        },
        {
          roomNo: 1005
          status: 'checked-in'
          user: 'Kevin Goslar'
        },
        {
          roomNo: 1006
          status: 'checked-in'
          user: 'Kevin Goslar'
        },
        {
          roomNo: 1007
          status: 'checked-in'
          user: 'Kevin Goslar'
        }
      ]
    },
    {
      floorNo: 2
      rooms: [
        {
          roomNo: 2000
          status: 'booked'
          user: 'gnuclient'
        },
        {
          roomNo: 2001
          status: 'booked'
          user: 'Gerald Ford'
        },
        {
          roomNo: 2002
          status: 'available'
        },
        {
          roomNo: 2003
          status: 'available'
        },
        {
          roomNo: 2004
          status: 'booked'
          user: 'celene dion'
        },
        {
          roomNo: 2005
          status: 'checked-in'
          user: 'Kevin Goslar'
        },
        {
          roomNo: 2006
          status: 'checked-in'
          user: 'Kevin Goslar'
        },
        {
          roomNo: 2007
          status: 'checked-in'
          user: 'Kevin Goslar'
        }
      ]
    },
    {
      floorNo: 3
      rooms: [
        {
          roomNo: 3000
          status: 'booked'
          user: 'gnuclient'
        },
        {
          roomNo: 3001
          status: 'booked'
          user: 'Gerald Ford'
        },
        {
          roomNo: 3002
          status: 'available'
        },
        {
          roomNo: 3003
          status: 'available'
        },
        {
          roomNo: 3004
          status: 'booked'
          user: 'celene dion'
        },
        {
          roomNo: 3005
          status: 'checked-in'
          user: 'Kevin Goslar'
        },
        {
          roomNo: 3006
          status: 'checked-in'
          user: 'Kevin Goslar'
        },
        {
          roomNo: 3007
          status: 'checked-in'
          user: 'Kevin Goslar'
        }
      ]
    }
  ]
