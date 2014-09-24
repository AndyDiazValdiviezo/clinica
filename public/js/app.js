(function() {
  function config($routeProvider, $interpolateProvider) {
    // Rutas
    $routeProvider.when('/tablas-maestras/colors', {
      templateUrl: 'templates/colors.html',
      controller: 'DataCtrl',
      resolve: {
        data: function(AjaxService) {
          return AjaxService.ajaxGet('/tablas-maestras/colors');
        },
      },
    });
    $routeProvider.when('/tablas-maestras/personas', {
      templateUrl: 'templates/personas.html',
      controller: 'DataCtrl',
      resolve: {
        data: function(AjaxService) {
          return AjaxService.ajaxGet('/tablas-maestras/personas');
        },
      },
    });

    // Cambio los símbolos {{}} por conflicto con laravel
    $interpolateProvider.startSymbol('//');
    $interpolateProvider.endSymbol('//');
  }

  angular
    .module('clinicaApp', ['ngRoute', 'ngAnimate', 'ui.bootstrap', 'angular-blocks', 'ngScrollTo'])
    .config(config);
})();