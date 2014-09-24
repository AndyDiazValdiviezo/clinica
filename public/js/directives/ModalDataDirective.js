(function() {
  function ModalDataDirective($timeout, ScrollTo) {
    return {
      restrict: 'EA',
      link: function($scope, $element, $attrs) {
      }
    }
  }

  angular
    .module('clinicaApp')
    .directive('modalData', ModalDataDirective);
})();