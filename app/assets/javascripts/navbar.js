$(document).ready( function() {
  
  /***
   * Preventing click from items disabled 
   **/
  $('.dropdown-menu').children('.disabled').click( function(event) {
    event.preventDefault();
  });
});
