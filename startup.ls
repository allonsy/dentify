dapp = require './dentify-app'
happ = require './hotel-app'
shareDB = require './shareDB'

dapp.run shareDB
happ.run shareDB
