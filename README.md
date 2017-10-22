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

### HW2 ###

I deployed a distillery release, but I did follow the "compromise" method outlined in the homework - I installed the neccesary tools (elixir, erlang, phoenix) on my VPS so that I was able to create the prod database via `MIX_ENV=prod mix ecto.create`. After that, I was able to get my application up and running smoothly with `MIX_ENV=prod PORT=8000 ./bin/microblog start`.

### HW3 ###

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
- better app handling of a user that isnt logged in
- after creating a new user, that user should be logged in as the current user


### HW5 ###

**Post timestamps**:

Although this wasn't a requirement for this homework assignment, I decided to add post timestamps cause it looks a whole lot nicer that way. Timestamps are showed in post show and index pages, as well as on the feed at the bottom of the user's own page.

**Likes/Unlikes**:

In this homework I added the functionality to like and unlike posts. I chose to handle all of this entirely in the message "show" page. I thought it looked a little messy to display options for the user's own posts as ell as for others' posts on the index page. This is because the user should have the option to delete their own post, but not anyone else's posts. This variance in displayed posts made the index look a little messy. Instead, I gave every post a "View Post" button to take a user to the show page for that post. At that point, any message can be likes/unliked, and the user is able to delete their own posts from here. A "like" adds "1" to the like counter (displayed below user's photo), and an "unlike" removes a like from that counter. The like/unlike buttons are dynamically rendered in Javascript depending on whether or not the user has already likes the given post. Like Instagram/Facebook, I chose to also allow the user to like their own posts.


**Deploy Script**:

My `deploy.bash` script is an adaptation of NTuck's `deploy.sh` script for the `nu_mart` site. It is designed to be run from the server itseld and can be used as follows:

~~~
./deploy.bash $TARGET_DIR
~~~

where `$TARGET_DIR` is the directory to deploy to. The script will prompt you to create the directory if it doesn't exist, to guard against potential accidents due to typos.


### HW7 ###

**NOTE:** Password validation and password hash handling were taken from ntuck's lecture notes on 10/16. More information on this can be found in `lib/microblog/accounts/user.ex`.

#### Admin user ####

The first created user will be the one and only `admin`. This allows him/her to delete and edit other's profiles, as well as delete their posts. The admin is not allowed to create posts for others or change their followers, since that seems weird.


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
