// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
  $("#dismiss_error").click(function(event) {
    $("#error").hide();
    event.preventDefault();
  });

  $("#dismiss_notice").click(function(event) {
    $("#notice").hide();
    event.preventDefault();
  });

  $(".reply_link").click(function(event) {
    $(this).nextAll(".edit_comment_form").hide();
    $(this).nextAll(".reply_form").show();
    event.preventDefault();
  });

  $(".cancel_reply").click(function(event) {
    $(this).closest(".reply_form").hide();
    event.preventDefault();
  });

  $(".edit_comment_link").click(function(event) {
    $(this).nextAll(".edit_comment_form").show();
    $(this).nextAll(".reply_form").hide();
    event.preventDefault();
  });

  $(".cancel_edit").click(function(event) {
    $(this).closest(".edit_comment_form").hide();
    event.preventDefault();
  });
});

