(function() {
  function PersonaDataDirective($timeout) {
    return {
      restrict: 'EA',
      link: function($scope, $element, $attrs) {
        // Natural
        $scope.camposNatural = function() {
          return $scope.dataFormulario.camposForm.natural;
        }

        $scope.camposJuridica = function() {
          return $scope.dataFormulario.camposForm.juridica;
        }

        $scope.datePicker = {};

        $scope.open = function($event) {
          $event.preventDefault();
          $event.stopPropagation();

          $timeout(function() {
            $scope.datePicker.opened = true;
          }, 10);
        };

        $scope.seleccionarTipo = function(tipo) {
          $scope.tipoPersona = tipo;
          $scope.dataFormulario.tipoPersona = $scope.tipoPersona;
        }

        $scope.agregarFila = function(tipo, key, fila, $event) {
          var fila = angular.copy(fila);

          if (typeof $scope.dataFormulario[tipo].camposDinamicos[key] == 'undefined') {
            $scope.dataFormulario[tipo].camposDinamicos[key] = [];
          }

          $scope.dataFormulario[tipo].camposDinamicos[key].push(fila);

          formatearNames(tipo, key);
          $event.preventDefault();
        }

        $scope.quitarFila = function(hashKey, key, tipo, $event) {
          for (var i = 0; i < $scope.dataFormulario[tipo].camposDinamicos[key].length; i++) {
            if ($scope.dataFormulario[tipo].camposDinamicos[key][i].$$hashKey == hashKey) {
              $scope.dataFormulario[tipo].camposDinamicos[key].splice(i, 1);
            };
          };

          formatearNames(tipo, key);
          $event.preventDefault();
        }

        function formatearNames(tipo, key) {
          var elementos = $scope.dataFormulario[tipo].camposDinamicos[key];

          for (var i = 0; i < elementos.length; i++) {
            for (var prop in elementos[i].campos) {
              var campo = elementos[i].campos[prop];
              var name = campo.name;
              var oldIndex = name.substring(name.lastIndexOf('['), name.lastIndexOf(']') + 1);

              if (oldIndex == '') {
                var newName = name + '[' + i + ']';

              } else {
                var newName = name.replace(oldIndex, '[' + i + ']');
              };

              $scope.dataFormulario[tipo].camposDinamicos[key][i].campos[prop].name = newName;
            }
          };
        }

      }
    }
  }

  angular
    .module('clinicaApp')
    .directive('personaData', PersonaDataDirective);
})();