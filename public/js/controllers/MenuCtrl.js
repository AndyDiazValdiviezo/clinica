(function() {
  function MenuCtrl($scope, $location) {
    $scope.go = function (ruta) {
      $location.path('/tablas-maestras/colors');
    }
  }

  angular
    .module('clinicaApp')
    .controller('MenuCtrl', MenuCtrl);
})();