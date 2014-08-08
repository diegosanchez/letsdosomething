app.factory( 'Complains', function($http) {
  var complaints = {};

  complaints.most_popular = function() {
    return $http.get( '/complaints/most_popular' );
  };

  return complaints;

});
