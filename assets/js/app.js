// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"

let handlebars = require("handlebars");

$(function() {
  if (!$("#render-number-likes-template").length > 0) {
    // This page shouldnt display any likes.
    return;
  }

  let tt = $($("#render-number-likes-template")[0]);
  let code = tt.html();
  let tmpl = handlebars.compile(code);

  let dd = $($("#number-likes")[0]);
  let path = dd.data('path');

  let likeButton = $($("#add-like")[0]);
  let current_user_id = likeButton.data('user-id');
  let message_id = likeButton.data('message-id')


  // need to implement this here instead of in the .eex templates
  // that way, if a user likes a page, we can have the button click add
  // the like and then fetch likes afterwards, so that the number of likes can be updated
  // without re-rendering the entire page.
  function fetch_likes() {

    // for this function, we want to receive a list of likes as the "data" variable, and
    // paste the length of the list into the template file...somehow...
    function got_likes(data) {
      console.log("heres the data length:");
      console.log(data["data"].length);
      var context = {num_likes: data["data"].length};
      let html = tmpl(context);
      console.log("heres the html:");
      console.log(html);
      dd.html(html);
    }

    $.ajax({
      url: path,
      data: {from_user_id: current_user_id, to_message_id: message_id},
      contentType: "application/json",
      dataType: "json",
      method: "GET",
      success: got_likes,
    });
  }

  function add_like() {
    let data = {like: {from_user_id: current_user_id, to_message_id: message_id}};

    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "POST",
      success: fetch_likes,
    });
  }

  likeButton.click(add_like);
  fetch_likes();
});

