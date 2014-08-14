(function() {
  function DataCtrl($scope, $rootScope, data, MainService, $http) {
    //////////////////////////////////////////
    // ----------OBJETOS INTERNOS---------- //
    //////////////////////////////////////////

    MainService.setInitData(data);

    $scope.dataFormulario = data.aFormulario;

    $scope.formData = {};
    $scope.formAccion;
    $scope.procesando = false;


    //////////////////////////////////////////
    // ----------MÉTODOS INTERNOS---------- //
    //////////////////////////////////////////

    $scope.procesarForm = function(accion) {
      if (!$scope.procesando) {
        $scope.procesando = true;

        if ($scope.formAccion == 'eliminar') {
          $scope.formData = $scope.formData.camposOcultos;
        };
        var data = $.param($scope.formData);
        var responsePromise = MainService.processForm(accion, data);

        responsePromise.then(function(data, status, headers, config) {
          switch ($scope.formAccion) {
            case 'agregar':
              $scope.$broadcast('recargarRegistros', data.aRegistros);
              $scope.$broadcast('recargarPaginador', data.aPaginador);
              $scope.$broadcast('actualizarTotalRegistros', data.totalRegistros);
              $scope.$broadcast('generarTextoPaginacion', data.aRegistros);
              $scope.$broadcast('cerrarModalData');
              break;

            case 'editar':
              $scope.$broadcast('recargarRegistros', data.aRegistros);
              $scope.$broadcast('cerrarModalData');
              break;

            case 'eliminar':
              $scope.$broadcast('recargarRegistros', data.aRegistros);
              $scope.$broadcast('recargarPaginador', data.aPaginador);
              $scope.$broadcast('actualizarTotalRegistros', data.totalRegistros);
              $scope.$broadcast('generarTextoPaginacion', data.aRegistros);
              $scope.$broadcast('cerrarModalRemove');
              break;
          }

          $scope.$broadcast('limpiarCamposBusqueda');
          $scope.$broadcast('limpiarRegistroSeleccionado');

          $scope.formData = {};

          setTimeout(function() {
            $scope.procesando = false;
          }, 2000);

        }, function(error) {
          console.log(error);
        });
      };
    }


    ///////////////////////////////////////////////
    // -----------------EVENTOS----------------- //
    // ---(comunicación entre controladores)---- //
    ///////////////////////////////////////////////

    $scope.$on('asignarAccion', function(evt, data) {
      $scope.formAccion = data;
    });

    $scope.$on('llenarCamposForm', function(evt, data) {
      $scope.formData = data;
    });

    $scope.$on('limpiarCamposForm', function() {
      $scope.formData = {};
    });
  }

  angular
    .module('clinicaApp')
    .controller('DataCtrl', DataCtrl);
})();