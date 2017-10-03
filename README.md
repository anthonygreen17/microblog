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

**HW2**

I deployed a distillery release, but I did follow the "compromise" method outlined in the homework - I installed the neccesary tools (elixir, erlang, phoenix) on my VPS so that I was able to create the prod database via `MIX_ENV=prod mix ecto.create`. After that, I was able to get my application up and running smoothly with `MIX_ENV=prod PORT=8000 ./bin/microblog start`.

**HW3**

I "borrowed" the entire session controller from the man himself, Professor Nat Tuck.

I think my app is functioning fairly well at this point. Here's some features:

- a user themselves will see "admin" type options on their own page, and will see options to follow others when looking at their page
- a user will have the option to follow another user on their homepage or through the user index. If the user is already folowing that user, an option to unfollow is presented
- if a user is deleted, all associated messages and follows are also deleted
- a logged in user can view their own follows at the bottom of their homepage
- a logged in user can view their own posts on their homepage (later, this will include posts in which the user is @mentioned)
- a user has the option to delete their own posts from their homepage as well as from the post index page. The user can like or share a post that is not their own
- navigation history is used to redirect the user to their most recent page, where appropriate (deleting posts, unfollowing users, etc)
- the follow /get and /show pages are restricted, cause it really doesnt make sense for them to be there
- a feed is implemented, which is a page in which a user can view all of their own posts as well as the posts of people that they follow

Things that aren't so good:

- still need proper timestamps for posts
- need to properly handle edge cases (ie: user's feed when they have no posts and don't follow anyone)



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
