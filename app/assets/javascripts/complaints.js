
$(document).ready( function() {

  function update_advocators( action_button ) {
    $(action_button).click( function(event) {
      var form = $(this).closest('form');
      var post = $.post( form.attr('action'), form.serialize() );

      post.done( function(  data, textStatus, jqXHR  ) {
        var content = $('#comp_' + data.id).find('.comp-advocators')
        content.empty()
        jQuery.each( data.advocators.reverse(), function( i, email ) {
          content.append( '<span><p>' + email + '</p></span>' );
        });
      });

      post.fail( function( jqXHR, textStatus, errorThrown) {
        console.debug( "errorThrown: " + errorThrown );
        console.debug( "textStatus: " + textStatus );
      });

      event.preventDefault();
    });
  };

  update_advocators( '.advocate' );
  update_advocators( '.relinquish' );


});

