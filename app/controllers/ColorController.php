<?php

class ColorController extends BaseController {
	private $nParClase = 1010;
	private $nCanReg   = 10;

	/**
	 * [Busca y envía los datos de la vista en formato json]
	 * @return [json] [Todos los datos de la vista]
	 */
	public function inicioJson() {
		// Botonera
		$dataBotonera = DB::select('CALL usp_Get_Permisos_Botonera_By_Usuario(1, 0, 0, 0, 1001, 1, 1001, 1, 1000, 100101);');

		$aBotonera = array();

		for ($i = 0; $i < count($dataBotonera); $i++) {
			$fila = $dataBotonera[$i];

			foreach ($fila as $property => $value) {
				if (HELPERS::isJSON($value)) {
					$aBotonera[$i][$property] = json_decode($value);
				} else {
					$aBotonera[$i][$property] = $value;
				}
			}
		}

		// Registros
		$nOriReg         = 0;
		$nCanReg         = $this->nCanReg;
		$nPagRegistro    = 1;
		$nParClase       = $this->nParClase;
		$cParNombre      = "";
		$cParDescripcion = "";

		$aRegistros = Parametro::filtrar($nOriReg, $nCanReg, $nPagRegistro, $nParClase, $cParNombre, $cParDescripcion);
		$aRegistros = $this->completarRegistros($aRegistros, 1);

		// Total de registros
		$aTodosRegistros = Parametro::buscarPorClase($this->nParClase);
		$totalRegistros  = count($aTodosRegistros);
		$nCanPaginas     = ceil($totalRegistros/$this->nCanReg);

		// Paginador
		$aPaginador = HELPERS::getPaginador($nCanPaginas, 1);

		// Formulario
		$aFormulario = array(
			'metodo' => 'POST',
			'accion' => array(
				'agregar'  => URL::route('colorsAgregar'),
				'editar'   => URL::route('colorsEditar'),
				'eliminar' => URL::route('colorsEliminar'),
			),
			'campos' => array(
				array(
					'label'       => 'Nombre',
					'name'        => 'cParDescripcion',
					'formType'    => 'text',
					'placeholder' => 'Nombre',
				),
			),
		);

		// Rutas
		$aRutas = array(
			'agregar'  => URL::route('colorsAgregar'),
			'editar'   => URL::route('colorsEditar'),
			'eliminar' => URL::route('colorsEliminar'),
			'filtrar'  => URL::route('colorsFiltrar'),
		);

		$data = array(
			'aBotonera'      => $aBotonera,
			'aRegistros'     => $aRegistros,
			'aPaginador'     => $aPaginador,
			'aFormulario'    => $aFormulario,
			'aRutas'         => $aRutas,
			'totalRegistros' => $totalRegistros,
		);

		return json_encode($data);
	}

	/**
	 * [Busca los y envía los registros]
	 * @return [json] [Registros en formato json]
	 */
	public function filtrarJson() {
		$pagina          = Input::get('pagina');
		$cParNombre      = Input::get('camposBusqueda.cParNombre');
		$cParDescripcion = Input::get('camposBusqueda.cParDescripcion');

		$pagina          = ($pagina === null)?'':$pagina;
		$cParNombre      = ($cParNombre === null)?'':$cParNombre;
		$cParDescripcion = ($cParDescripcion === null)?'':$cParDescripcion;

		// Registros
		$nCanReg      = $this->nCanReg;
		$nOriReg      = ($pagina-1)*$nCanReg;
		$nPagRegistro = 1;
		$nParClase    = $this->nParClase;

		$aRegistros = Parametro::filtrar($nOriReg, $nCanReg, $nPagRegistro, $nParClase, $cParNombre, $cParDescripcion);
		$aRegistros = $this->completarRegistros($aRegistros, $pagina);

		// Total de registros
		$nPagRegistro   = 0;
		$totalRegistros = count(Parametro::filtrar($nOriReg, $nCanReg, $nPagRegistro, $nParClase, $cParNombre, $cParDescripcion));
		$nCanPaginas    = ceil($totalRegistros/$nCanReg);

		// Paginador
		$aPaginador = HELPERS::getPaginador($nCanPaginas, $pagina);

		$data = array(
			'aRegistros'     => $aRegistros,
			'aPaginador'     => $aPaginador,
			'totalRegistros' => $totalRegistros,
		);

		return json_encode($data);
	}

	/**
	 * [Guardo un nuevo registro]
	 * @return [json] [Respuesta en formato json]
	 */
	public function agregarJson() {
		$nParClase       = $this->nParClase;
		$cParNombre      = Input::get('cParDescripcion');
		$cParDescripcion = Input::get('cParDescripcion');

		$newParametro = Parametro::registrar($nParClase, $cParNombre, $cParDescripcion);

		// Registros
		$nOriReg         = 0;
		$nCanReg         = $this->nCanReg;
		$nPagRegistro    = 1;
		$nParClase       = $this->nParClase;
		$cParNombre      = "";
		$cParDescripcion = "";

		$aRegistros = Parametro::filtrar($nOriReg, $nCanReg, $nPagRegistro, $nParClase, $cParNombre, $cParDescripcion);
		$aRegistros = $this->completarRegistros($aRegistros, 1);

		// Total de registros
		$aTodosRegistros = Parametro::buscarPorClase($this->nParClase);
		$totalRegistros  = count($aTodosRegistros);
		$nCanPaginas     = ceil($totalRegistros/$this->nCanReg);

		// Paginador
		$aPaginador = HELPERS::getPaginador($nCanPaginas, 1);

		$data = array(
			'aRegistros'     => $aRegistros,
			'aPaginador'     => $aPaginador,
			'totalRegistros' => $totalRegistros,
		);

		return json_encode($data);
	}

	public function editarJson() {
		$nParCodigo      = Input::get('camposOcultos.nParCodigo.value');
		$nParClase       = Input::get('camposOcultos.nParClase.value');
		$cParNombre      = Input::get('cParNombre');
		$cParDescripcion = Input::get('cParDescripcion');

		$updParametro = Parametro::actualizar($nParCodigo, $nParClase, $cParNombre, $cParDescripcion);

		// Registros
		$nOriReg         = 0;
		$nCanReg         = $this->nCanReg;
		$nPagRegistro    = 1;
		$nParClase       = $this->nParClase;
		$cParNombre      = "";
		$cParDescripcion = "";

		$aRegistros = Parametro::filtrar($nOriReg, $nCanReg, $nPagRegistro, $nParClase, $cParNombre, $cParDescripcion);
		$aRegistros = $this->completarRegistros($aRegistros, 1);

		$data = array(
			'aRegistros' => $aRegistros,
		);

		return json_encode($data);
	}

	public function eliminarJson() {
		$nParCodigo = Input::get('nParCodigo.value');
		$nParClase  = Input::get('nParClase.value');
		$nParEstado = 0;

		$updnParCodigo = Parametro::eliminar($nParCodigo, $nParClase, $nParEstado);

		// Registros
		$nOriReg         = 0;
		$nCanReg         = $this->nCanReg;
		$nPagRegistro    = 1;
		$nParClase       = $this->nParClase;
		$cParNombre      = "";
		$cParDescripcion = "";

		$aRegistros = Parametro::filtrar($nOriReg, $nCanReg, $nPagRegistro, $nParClase, $cParNombre, $cParDescripcion);
		$aRegistros = $this->completarRegistros($aRegistros, 1);

		// Total de registros
		$aTodosRegistros = Parametro::buscarPorClase($this->nParClase);
		$totalRegistros  = count($aTodosRegistros);
		$nCanPaginas     = ceil($totalRegistros/$this->nCanReg);

		// Paginador
		$aPaginador = HELPERS::getPaginador($nCanPaginas, 1);

		$data = array(
			'aRegistros'     => $aRegistros,
			'aPaginador'     => $aPaginador,
			'totalRegistros' => $totalRegistros,
		);

		return json_encode($data);
	}

	/////////////////////////////////////////////////////
	// ---------------MÉTODOS INTERNOS--------------- //
	/////////////////////////////////////////////////////

	private function completarRegistros($aRegistros, $pagina) {
		for ($i = 0; $i < count($aRegistros); $i++) {
			$aRegistros[$i]['index']    = ($this->nCanReg*($pagina-1))+$i+1;
			$aRegistros[$i]['formData'] = array(
				'cParDescripcion' => $aRegistros[$i]['cParDescripcion'],
				'camposOcultos'   => array(
					'nParCodigo' => array(
						'name'  => 'nParCodigo',
						'value' => $aRegistros[$i]['nParCodigo'],
					),
					'nParClase' => array(
						'name'  => 'nParClase',
						'value' => $this->nParClase,
					),
				),
			);
		}

		return $aRegistros;
	}
}
?>