(function() {
  function RegistrosService($http) {

    this.initData = {};
    this.paginaActual = 1;
    this.registroSeleccionado;
    this.camposBusqueda = {};
    this.botoneraAccion = '';

  }

  angular
    .module('clinicaApp')
    .service('RegistrosService', RegistrosService);
})();