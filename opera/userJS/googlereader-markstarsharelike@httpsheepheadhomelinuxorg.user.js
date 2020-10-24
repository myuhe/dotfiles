// ==UserScript==
// @name           Google Reader - mark star share like
// @namespace      http://sheephead.homelinux.org
// @include        https://*.google.com/reader/view/*
// @include        http://*.google.com/reader/view/*
// @include        htt*://*.google.*/reader/view*
// @require        http://ajax.googleapis.com/ajax/libs/jquery/1.3/jquery.min.js
// ==/UserScript==

var all_key = 188; // the ','-key キーバインドを割り当てる

jQuery.noConflict();

(function() {
     var orig_button = jQuery('#entries-down:first');
     var new_button = orig_button.clone();
     
     // init new button
     new_button.attr('id', 'star-share-like')
         .find('.goog-button-body')
         .text('mark star share and like');
     // insert new button
     orig_button.after(new_button);
     
     // create function
     var star_share_like = function() {
         evt = document.createEvent('KeyboardEvent');
         evt.initKeyEvent('keypress', 1, 1, null, 0, 0, 1, 0, 83, 0);
         document.body.dispatchEvent(evt);
         evt.initKeyEvent('keypress', 1, 1, null, 0, 0, 0, 0, 83, 0);
         document.body.dispatchEvent(evt);
         evt.initKeyEvent('keypress', 1, 1, null, 0, 0, 0, 0, 76, 0);
         document.body.dispatchEvent(evt);

     };

     // bind click-handler
     new_button.click(star_share_like);

     // bind key-handler
     jQuery(document).keydown(function(e) {
                                  if ( ! (e.altKey || e.ctrlKey || e.metaKey) && e.which == all_key ) {
                                      star_share_like();
                                  }
                              });

 })();
