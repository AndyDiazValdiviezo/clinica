(function() {
  function PaginadorCtrl($scope, MainService) {
    //////////////////////////////////////////
    // ----------OBJETOS INTERNOS---------- //
    //////////////////////////////////////////

    $scope.paginaActual = 1;
    $scope.camposBusqueda = {};
    $scope.dataPaginador = MainService.getInitData().aPaginador;
    $scope.dataRutas = MainService.getInitData().aRutas;
    $scope.totalRegistros = MainService.getInitData().totalRegistros;


    //////////////////////////////////////////
    // ----------MÉTODOS INTERNOS---------- //
    //////////////////////////////////////////

    $scope.paginar = function(boton) {
      $scope.asignarBotonActivo(boton);
      var pagina = boton.pagina;
      $scope.paginaActual = pagina;
      $scope.$emit('actualizarPaginaActual', pagina);

      var objData = {
        'pagina': pagina,
        'camposBusqueda': $scope.camposBusqueda,
      };

      var data = $.param(objData);
      var responsePromise = MainService.postAsync($scope.dataRutas.filtrar, data);

      responsePromise.then(function(data, status, headers, config) {
        $scope.$emit('recargarRegistros', data.aRegistros);
        $scope.generarTextoPaginacion(data.aRegistros);
      }, function(error) {
        console.log(error);
      });
    }

    $scope.asignarBotonActivo = function(boton) {
      for (var i = 0; i < $scope.dataPaginador.length; i++) {
        $scope.dataPaginador[i].activo = false;
      };

      if (boton.inicial || boton.final) {
        for (var i = 0; i < $scope.dataPaginador.length; i++) {
          if ($scope.dataPaginador[i].pagina == boton.pagina && $scope.dataPaginador[i] != boton) {
            $scope.dataPaginador[i].activo = true;
          };
        };
      } else {
        boton.activo = true;
      };
    };

    $scope.generarTextoPaginacion = function(dataRegistros) {
      var texto = '';

      if (dataRegistros.length > 0) {
        var regInicio = dataRegistros[0].index;
        var regFin = dataRegistros[dataRegistros.length - 1].index;

        texto = 'Registros ' + regInicio + ' - ' + regFin + ' de ' + $scope.totalRegistros;
      };

      return texto;
    }

    ///////////////////////////////////////////////
    // -----------------EVENTOS----------------- //
    // ---(comunicación entre controladores)---- //
    ///////////////////////////////////////////////

    $scope.$on('recargarPaginador', function(evt, data) {
      $scope.dataPaginador = data;
    });

    $scope.$on('actualizarCamposBusqueda', function(evt, data) {
      $scope.camposBusqueda = data;
    });

    $scope.$on('actualizarPaginaActual', function(evt, data) {
      $scope.paginaActual = data;
    });

    $scope.$on('limpiarCamposBusqueda', function(evt) {
      $scope.camposBusqueda = {};
    });

    $scope.$on('actualizarTotalRegistros', function(evt, data) {
      $scope.totalRegistros = data;
    });

    $scope.$on('generarTextoPaginacion', function(evt, data) {
      $scope.generarTextoPaginacion(data);
    });
  }

  angular
    .module('clinicaApp')
    .controller('PaginadorCtrl', PaginadorCtrl);
})();