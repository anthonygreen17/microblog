# Microblog #

My Microblog application is up and running at:

~~~
microblog.anthonygreen17.com
~~~

I added the message resource. They can be viewed at:

~~~
microblog.anthonygreen17.com/messages
~~~

My git repo is located at 

~~~
https://github.com/anthonygreen17/microblog
~~~

I deployed a distillery release, but I did follow the "compromise" method outlined in the homework - I installed the neccesary tools (elixir, erlang, phoenix) on my VPS so that I was able to create the prod database via `MIX_ENV=prod mix ecto.create`. After that, I was able to get my application up and running smoothly with `MIX_ENV=prod PORT=8000 ./bin/microblog start`.



## Other pre-generated stuff, left here for reference ##
To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
