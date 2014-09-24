(function() {
  function BotoneraCtrl($scope, $modal, RegistrosService, AjaxService) {
    //////////////////////////////////////////
    // ----------OBJETOS INTERNOS---------- //
    //////////////////////////////////////////
    $scope.dataBotonera = function(value) {
      if (value === undefined) {
        return RegistrosService.initData.dataBotonera;
      } else {
        RegistrosService.initData.dataBotonera = value;
      };
    }

    $scope.dataRutas = function(value) {
      if (value === undefined) {
        return RegistrosService.initData.dataRutas;
      } else {
        RegistrosService.initData.dataRutas = value;
      };
    }

    $scope.registroSeleccionado = function(value) {
      if (value === undefined) {
        return RegistrosService.registroSeleccionado;
      } else {
        RegistrosService.registroSeleccionado = value;
      };
    }

    $scope.botoneraAccion = function(value) {
      if (value === undefined) {
        return RegistrosService.botoneraAccion;
      } else {
        RegistrosService.botoneraAccion = value;
      };
    }


    //////////////////////////////////////////
    // ----------MÉTODOS INTERNOS---------- //
    //////////////////////////////////////////

    $scope.accionar = function(botoneraAccion) {
      $scope.botoneraAccion(botoneraAccion);

      switch (botoneraAccion) {
        case 'agregar':
          var ruta = $scope.dataRutas().agregar;
          var responsePromise = AjaxService.ajaxGet(ruta);

          responsePromise.then(function(data, status, headers, config) {
            console.log(data);
            $modal.open({
              templateUrl: 'templates/persona-data.html',
              controller: 'ModalDataCtrl',
              size: 'md',
              backdrop: 'static',
              resolve: {
                data: function() {
                  return data;
                },
                ruta: function() {
                  return ruta;
                },
                accion: function() {
                  return botoneraAccion;
                },
              },
            });

          }, function(error) {
            console.log(error);
          });
          break;

        case 'editar':
          if ($scope.registroSeleccionado()) {
            var ruta = $scope.dataRutas().editar.url;
            var parametros = $scope.dataRutas().editar.parametros;

            for (var i = 0; i < parametros.length; i++) {
              var param = parametros[i];
              ruta = ruta.replace('-p-' + param, $scope.registroSeleccionado()[param]);
            };

            var responsePromise = AjaxService.ajaxGet(ruta);

            responsePromise.then(function(data, status, headers, config) {
              console.log(data);
              var modalData = $modal.open({
                templateUrl: 'templates/persona-data.html',
                controller: 'ModalDataCtrl',
                size: 'md',
                resolve: {
                  data: function() {
                    return data;
                  },
                  ruta: function() {
                    return ruta;
                  },
                  accion: function() {
                    return botoneraAccion;
                  },
                },
              });

            }, function(error) {
              console.log(error);
            });
          } else {
            $modal.open({
              templateUrl: 'templates/alerta.html',
              controller: 'ModalAlertaCtrl',
              size: 'sm',
              resolve: {},
            });
          };
          break;

        case 'eliminar':
          if ($scope.registroSeleccionado()) {
            var ruta = $scope.dataRutas().eliminar.url;
            var parametros = $scope.dataRutas().editar.parametros;

            for (var i = 0; i < parametros.length; i++) {
              var param = parametros[i];
              ruta = ruta.replace('-p-' + param, $scope.registroSeleccionado()[param]);
            };

            var modalData = $modal.open({
              templateUrl: 'templates/eliminar.html',
              controller: 'ModalEliminarCtrl',
              size: 'md',
              resolve: {
                ruta: function() {
                  return ruta;
                },
              },
            });
          } else {
            $modal.open({
              templateUrl: 'templates/alerta.html',
              controller: 'ModalAlertaCtrl',
              size: 'sm',
              resolve: {},
            });
          };
          break;
      }
    }

  }

  angular
    .module('clinicaApp')
    .controller('BotoneraCtrl', BotoneraCtrl);
})();