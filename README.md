# Oprah

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

# Deploying

First you'll need a postgres instance with a database named `oprah_dev`.
If you don't have one hand you can do something like:

```
docker run -d --name oprah_dev -v /var/lib/oprah_dev:/var/lib/postgresql/data postgres:9.5
```

Next you need a docker image.
To build a version of the oprah image you can do the following:

```
brunch build --production
build -t hqmq/oprah:0.1.0 .
docker push hqmq/oprah:0.1.0
git tag -v0.1.0
git push --tags
```

Finally we start the docker and give it the necessary environment variables:

```
docker run --name oprah -d -p 4000:4000 -e PORT=4000\
-e AUTH_CLIENT_ID=123\
-e AUTH_CLIENT_SECRET=123\
-e AUTH_SITE=http://localhost:4000/\
-e AUTH_AUTHORIZE_URL=http://localhost:4000/oauth/authorize\
-e AUTH_TOKEN_URL=http://localhost:4000/oauth/token
hqmq/oprah:0.1.0
```


## Events

This application uses an event stream to build up an in-memory data structure that represents the current state of the application.
The best way to understand the application is to understand the events that make it up.

__New User__

This event generally occurs when a new user authenticates via oauth.

```json
{
  "occured_at": "2017-07-01T23:50:07.123Z",
  "type": "new_user",
  "data": {
    "avatar_url":" https://secure.gravatar.com/avatar/6e4118591d545eb136c28f2793711698?s=80&d=identicon",
    "gitlab_id": 1234,
    "id": "ClyCcm-tCggjRSojr8QKmA==",
    "name": "Michael Ries"
  }
}
```

__Nomination__

One teammate nominating another teammate.

```json
{
  "occured_at": "2017-07-05T16:13:22.000Z",
  "type": "nomination",
  "data": {
    "body": "some markdown text",
    "nominated_by": "AijYMnNNyG5BQaawdtQnaQ==",
    "nominee": "F3aIEr0mlE_LzolrBJehww=="
  }
}
```
