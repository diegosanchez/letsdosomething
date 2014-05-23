//= require dropzone

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

/*
function dropzone_setup() {
  var zone = $('#zone');
  var form_url = zone.closest('form').prop('action');
  var drop_zone = zone.dropzone( { 
    url: form_url,
    forceFallback: true,
    uploadMultiple: true,
    previewsContainer: false,
    autoProcessQueue: false,
  }
  } );
};
*/


function dropzone_setup() {
  var zone = $('#zone');
  var form_url = zone.closest('form').prop('action');
  zone.dropzone( { 
    url: form_url,
    previewsContainer: false,
    autoProcessQueue: false,
    init: function() {
      var myDropzone = this;

      // First change the button to actually tell Dropzone to process the queue.
      $(':submit').on( "click", function( e ) {
        e.preventDefault();
        e.stopPropagation();
        myDropzone.processQueue();
      });
    },
    sendingmultiple: function() {
     x 
    },
    successmultiple: function(files, response) {
    },
    errormultiple: function(files, response) {
    }
  } );
};


$(document).ready( function() {
  Dropzone.autoDiscover = false;

  update_advocators( '.advocate' );
  update_advocators( '.relinquish' );

  dropzone_setup();

});

