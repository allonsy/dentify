require! {
  'express' : express
}


app = express!
  ..get '/', (req, res) ->
    res.send 'Hello World'
  ..listen 3000
