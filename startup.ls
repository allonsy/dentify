dapp = require './dentify-app'
require './hotel-app'
shareDB = require './shareDB'

dapp.run(shareDB)
