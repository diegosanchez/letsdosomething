app.directive( 'complaint', function() {
  return {
    restrict: 'E',
    scope: {
      obj: '@obj' 
    },
    templateUrl: 'complaint.html',
    link: function() {
      console.log( "complaint directive created" );
    }
  };
});

/*
$(document).ready( function() {
  var proves = $('.proves');
  var single_file = proves.html();
  var anchor_add = '<a href="#" class="glyphicon glyphicon-plus add-file"/>'
  var anchor_remove = '<a href="#" class="glyphicon glyphicon-minus remove-file" />'

  update_advocators( '.advocate' );
  update_advocators( '.relinquish' );

  setup_add_file_button();
  setup_remove_file_button();
  load_default_buttons();


  function setup_remove_file_button() {

    $(document).on( 'click', '.remove-file', function( e ) {
      $(this).parent().remove();
      e.preventDefault();
    });
  }

  function setup_add_file_button() {

    $(document).on( 'click', '.add-file', function( e ) {
      proves.prepend( single_file );

      var last = $('.single-file').first();

      last.append( anchor_remove );

      e.preventDefault();
    });
  }

  function load_default_buttons() {
    var last = $('.single-file').last();
    last.append( anchor_add );
  }

  function remove_button( single_file, btn_tag) {
    if ( !single_file || !btn_tag ) 
      return;

    var btn = single_file.find(btn_tag);

    if ( btn ) 
      btn.remove();

    return;
  }

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

});
*/
