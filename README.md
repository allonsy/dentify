# !dentify
A universal identity platform

## Terminology

  Server: Backend server used for verification
  
  Receiver: Vendor app used to receive NFC communication and talk to Server
  
  User: User app used to initiate NFC communication

## Database Setup

  1. Download postgresql ```brew install postgresql```
  2. Start the postgres server ```postgres -D /usr/local/pgsql/data >logfile 2>&1 &```
  3. Connect to db and create your tables... ```psql```

## Run it!
  1. ```npm install```
  2. ```npm start```
