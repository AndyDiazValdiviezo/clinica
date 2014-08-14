(function() {
  function BotoneraCtrl($scope, MainService) {
    //////////////////////////////////////////
    // ----------OBJETOS INTERNOS---------- //
    //////////////////////////////////////////

    $scope.dataBotonera = MainService.getInitData().aBotonera;
    $scope.registroSeleccionado;
    $scope.accion;

    $scope.modalData = angular.element('#modal-data');
    $scope.modalRemove = angular.element('#modal-remove');
    $scope.modalAlert = angular.element('#modal-alert');


    //////////////////////////////////////////
    // ----------MÉTODOS INTERNOS---------- //
    //////////////////////////////////////////

    $scope.botoneraAccion = function(accion, ruta) {
      $scope.accion = accion;
      $scope.$emit('asignarAccion', accion);

      switch (accion) {
        case 'agregar':
          MainService.setFormAccion = 'agregar';
          $scope.$emit('limpiarCamposForm');
          $scope.modalData.modal('show');
          break;

        case 'editar':
          if ($scope.registroSeleccionado) {
            MainService.setFormAccion = 'editar';
            $scope.$emit('llenarCamposForm', $scope.registroSeleccionado.formData);
            $scope.modalData.modal('show');
          } else {
            $scope.modalAlert.modal('show');
          };
          break;

        case 'eliminar':
          if ($scope.registroSeleccionado) {
            MainService.setFormAccion = 'eliminar';
            $scope.$emit('llenarCamposForm', $scope.registroSeleccionado.formData);
            $scope.modalRemove.modal('show');
          } else {
            $scope.modalAlert.modal('show');
          };
          break;
      }
    }

    $scope.cerrarModalData = function() {
      $scope.modalData.modal('hide');
    }

    $scope.cerrarModalRemove = function() {
      $scope.modalRemove.modal('hide');
    }


    ///////////////////////////////////////////////
    // -----------------EVENTOS----------------- //
    // ---(comunicación entre controladores)---- //
    ///////////////////////////////////////////////

    $scope.$on('cerrarModalData', function() {
      $scope.cerrarModalData();
    });

    $scope.$on('cerrarModalRemove', function() {
      $scope.cerrarModalRemove();
    });

    $scope.$on('asignarRegistroSeleccionado', function(evt, data) {
      $scope.registroSeleccionado = data;
    });

    $scope.$on('limpiarRegistroSeleccionado', function(evt) {
      $scope.registroSeleccionado = undefined;
    });
  }

  angular
    .module('clinicaApp')
    .controller('BotoneraCtrl', BotoneraCtrl);
})();