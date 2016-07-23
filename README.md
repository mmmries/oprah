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
docker run -d --name oprah_db -v /var/lib/oprah_db:/var/lib/postgresql/data postgres:9.5
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
docker run --name oprah -d -p 4000:4000 -e PORT=4000 -e GITHUB_CLIENT_ID=123 -e GITHUB_CLIENT_SECRET=123 -e SECRETE_KEY_BASE=123 -e POSTGRES_USERNAME=pguser -e POSTGRES_PASSWORD=pgpass -e POSTGRES_HOST=localhost hqmq/oprah:0.1.0
```


## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
