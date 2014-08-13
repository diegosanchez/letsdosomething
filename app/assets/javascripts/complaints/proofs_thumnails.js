$(document).ready( function() {
  if ! $('.galleria') 
    return;

  Galleria.loadTheme('/assets/galleria/galleria.classic.js');
  Galleria.run('.galleria');
});
