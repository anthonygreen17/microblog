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
  let number_likes_template = handlebars.compile(code);

  tt = $($("#render-like-button-template")[0]);
  code = tt.html();
  let like_button_template = handlebars.compile(code);

  tt = $($("#render-unlike-button-template")[0]);
  code = tt.html();
  let unlike_button_template = handlebars.compile(code);

  let number_likes_dest = $($("#number-likes")[0]);
  let path = number_likes_dest.data('path');

  let likeButton = $($("#like-button")[0]);
  let current_user_id = likeButton.data('user_id');
  let message_id = likeButton.data('message_id')

  let unlikeButton = $($("#unlike-button")[0]);

  console.log("current user id:");
  console.log(current_user_id);
  console.log("path");
  console.log(path);


  // attach this callback to the likeButton to enable a user to like a post
  function add_like() {
    let data = {like: {from_user_id: current_user_id, to_message_id: message_id}};

    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "POST",
      success: fetch_likes_for_message,
    });
  }

  // in order to remove a like, first make a request to get the like by user_id and message_id. Then,
  // use that response to get the proper like_id in order to delete
  function remove_like() {
    let data = {from_user_id: current_user_id, to_message_id: message_id};

    $.ajax({
      url: path,
      data: JSON.stringify(data),
      contentType: "application/json",
      dataType: "json",
      method: "DELETE",
      success: fetch_likes_for_message,
    });
  }


  // need to implement this here instead of in the .eex templates
  // that way, if a user likes a page, we can have the button click add
  // the like and then fetch likes afterwards, so that the number of likes can be updated
  // without re-rendering the entire page.
  function render_like_or_unlike_button() {

    // for this function, we want to receive a list of likes as the "data" variable, and
    // paste the length of the list into the template file...somehow...
    function got_likes(data) {

      if (data["data"].length == 0) {
        console.log("user has not yet liked this message.");
        let html = like_button_template();
        likeButton.html(html);
        likeButton.click(add_like);
      } else {
        console.log("user has liked this message already!");
        let html = unlike_button_template();
        unlikeButton.html(html);
        unlikeButton.click(remove_like);
      }
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

  function fetch_likes_for_message() {

    // for this function, we want to receive a list of likes as the "data" variable, and
    // paste the length of the list into the template file...somehow...
    function got_likes(data) {
      console.log("total likes for this message:");
      console.log(data["data"].length);

      var context = {num_likes: data["data"].length};
      let html = number_likes_template(context);
      number_likes_dest.html(html);
    }
    console.log("about to fetch likes for message...");

    $.ajax({
      url: path,
      data: {to_message_id: message_id},
      contentType: "application/json",
      dataType: "json",
      method: "GET",
      success: got_likes,
    });
  }

  

  // likeButton.click(add_like);
  fetch_likes_for_message();
  render_like_or_unlike_button();
});

