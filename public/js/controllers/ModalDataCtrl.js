(function() {
  function ModalDataCtrl($scope, $modal, $modalInstance, $timeout, RegistrosService, AjaxService, data, ruta, accion, ScrollTo) {
    //////////////////////////////////////////
    // ----------OBJETOS INTERNOS---------- //
    //////////////////////////////////////////
    $scope.submited = false;
    $scope.dataFormulario = data.dataFormulario;

    $scope.registroSeleccionado = function(value) {
      if (value === undefined) {
        return RegistrosService.registroSeleccionado;
      } else {
        RegistrosService.registroSeleccionado = value;
      };
    }

    //////////////////////////////////////////
    // ----------MÉTODOS INTERNOS---------- //
    //////////////////////////////////////////
    $scope.cancel = function() {
      $modalInstance.dismiss('cancel');
    }

    $scope.setFormScope = function(scope) {
      $scope.formScope = scope;
    }

    $scope.submit = function() {
      $scope.submited = true;

      if ($scope.formScope.formData.$valid) {
        var dataSubmit = $.param($scope.dataFormulario);
        var responsePromise = AjaxService.ajaxPostJson(ruta, dataSubmit);

        responsePromise.then(function(data, status, headers, config) {
          console.log(data);
          RegistrosService.initData.dataRegistros = data.dataRegistros;

          if (accion !== 'editar') {
            RegistrosService.initData.dataPaginador = data.dataPaginador;
            RegistrosService.initData.totalRegistros = data.totalRegistros;
          };

          $scope.registroSeleccionado(false);
          $modalInstance.dismiss('cancel');

        }, function(error) {
          console.log(error);
        });

      } else {
        for (var prop in $scope.formScope.formData.$error) {
          if ($scope.formScope.formData.$error.hasOwnProperty(prop)) {

            for (var i = 0; i < $scope.formScope.formData.$error[prop].length; i++) {
              ScrollTo.idOrName($scope.formScope.formData.$error[prop][i].$name);
              break;
            };
          }
        }
      };
    }
  }

  angular
    .module('clinicaApp')
    .controller('ModalDataCtrl', ModalDataCtrl);
})();