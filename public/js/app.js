(function() {
  function config($routeProvider, $interpolateProvider) {
    // Rutas
    $routeProvider.when('/tablas-maestras/personas', {
      templateUrl: 'templates/personas.html',
      controller: 'DataCtrl',
      resolve: {
        data: function(AjaxService) {
          return AjaxService.ajaxGet('/tablas-maestras/personas');
        },
      },
    });
    $routeProvider.when('/laboratorios/resultados', {
      templateUrl: 'templates/resultados.html',
      controller: 'DataCtrl',
      resolve: {
        data: function(AjaxService) {
          return AjaxService.ajaxGet('/laboratorios/resultados');
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