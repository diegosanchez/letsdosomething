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

function dropzone_setup() {
  var zone = $('#zone');
  var new_form = zone.closest('form');
  var form_url = new_form.prop('action');
  zone.dropzone( { 
    url: form_url,
    autoProcessQueue: false,
    enqueueForUpload: false,
    uploadMultiple:true,
    parallelUploads: 1000, /* magic number */
    init: function() {
      var myDropzone = this;

      // First change the button to actually tell Dropzone to process the queue.
      $(':submit').on( "click", function( e ) {
        if ( myDropzone.getQueuedFiles().length > 0) { 
          e.preventDefault();
          e.stopPropagation();
          myDropzone.processQueue();
        }
      });
    },
    sendingmultiple: function(file, xhr, formData) {
      new_form.find( ":input" ).each( function( index, input ) {
        formData.append( input.name, input.value );
      });
    },
    successmultiple: function(files, response) {
    },
    errormultiple: function(files, response) {
    }
  } );
};


$(document).ready( function() {
  update_advocators( '.advocate' );
  update_advocators( '.relinquish' );

  Dropzone.autoDiscover = false;
  dropzone_setup();
});

