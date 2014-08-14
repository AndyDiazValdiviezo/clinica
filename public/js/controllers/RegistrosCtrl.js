(function() {
  function RegistrosCtrl($scope, $rootScope, MainService) {
    //////////////////////////////////////////
    // ----------OBJETOS INTERNOS---------- //
    //////////////////////////////////////////

    $scope.dataRegistros = MainService.getInitData().aRegistros;
    $scope.dataRutas = MainService.getInitData().aRutas;
    $scope.paginaActual = 1;
    $scope.camposBusqueda = {};


    //////////////////////////////////////////
    // ----------MÉTODOS INTERNOS---------- //
    //////////////////////////////////////////

    $scope.seleccionarRegistro = function(registro) {
      if (registro.selected) {
        registro.selected = false;
        $rootScope.$broadcast('limpiarRegistroSeleccionado');

      } else {
        for (var i = 0; i < $scope.dataRegistros.length; i++) {
          $scope.dataRegistros[i].selected = false;
        };

        registro.selected = true;
        $rootScope.$broadcast('asignarRegistroSeleccionado', registro);
      };
    }

    $scope.buscar = function() {
      $scope.paginaActual = 1;
      $scope.$broadcast('actualizarPaginaActual', 1);
      $scope.$broadcast('actualizarCamposBusqueda', $scope.camposBusqueda);
      $rootScope.$broadcast('limpiarRegistroSeleccionado');


      var objData = {
        'pagina': 1,
        'camposBusqueda': $scope.camposBusqueda,
      };

      var data = $.param(objData);
      var responsePromise = MainService.postAsync($scope.dataRutas.filtrar, data);

      responsePromise.then(function(data, status, headers, config) {
        $scope.dataRegistros = data.aRegistros;
        $scope.$broadcast('recargarPaginador', data.aPaginador);
        $scope.$broadcast('actualizarTotalRegistros', data.totalRegistros);
        $scope.$broadcast('generarTextoPaginacion', data.aRegistros);

      }, function(error) {
        console.log(error);
      });
    }


    ///////////////////////////////////////////////
    // -----------------EVENTOS----------------- //
    // ---(comunicación entre controladores)---- //
    ///////////////////////////////////////////////

    $scope.$on('recargarRegistros', function(evt, data) {
      $scope.dataRegistros = data;
    });

    $scope.$on('actualizarPaginaActual', function(evt, data) {
      $scope.paginaActual = data;
    });

    $scope.$on('limpiarCamposBusqueda', function (evt) {
      $scope.camposBusqueda = {};
    });
  }

  angular
    .module('clinicaApp')
    .controller('RegistrosCtrl', RegistrosCtrl);
})();