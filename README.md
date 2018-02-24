# Screener

### A stock quote/screener server based on technical analysis

To start your Phoenix server:

  * Install dependencies with: `$ mix deps.get`
  * Create and migrate your database with: `$ mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with: `$ cd assets && npm install`
  * Start Phoenix endpoint with: `$ mix phx.server`

Before you run your Phoenix server setup your API key:

  * Get your API key here: https://www.alphavantage.co/support/#api-key
  * Create a local env file with: `$ touch .env`
  * Add the following line to your .env file: `export API_KEY="<YOUR API KEY>"`
  * Run: `$ source .env`
  * Don't be a chump... make sure to add your .env file to .gitignore

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
