app.controller( 'mostPopular', function($scope, Complains) {
  console.debug('Controller has been create!');
  $scope.top_complains = [];

  Complains.most_popular()
    .success(function(data, status, headers, config) {
      $scope.top_complains = angular.fromJson( data );
      console.debug( $scope.top_complains );
    })
    .error(function(data, status, headers, config) {
      console.error( status );
    });
});
