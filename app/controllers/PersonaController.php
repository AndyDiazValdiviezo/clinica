<?php
class PersonaController extends BaseController {
	private $nCanReg   = 10;
	private $nParClase = 1010;

	private $dataFormulario = array(
		'tipoPersona'  => 'natural',
		'tiposPersona' => array(
			array(
				'key'    => 'natural',
				'nombre' => 'Natural',
				),
			array(
				'key'    => 'juridica',
				'nombre' => 'Jurídica',
				),
			),
		'camposForm' => array(
			'natural' => array(
				'cPerNombre' => array(
					'label'       => 'Nombre',
					'value'       => '',
					'placeholder' => 'Nombre',
					'required'    => true,
					),
				'cPerNatApePaterno' => array(
					'label'       => 'Apellido paterno',
					'value'       => '',
					'placeholder' => 'Apellido paterno',
					'required'    => true,
					),
				'cPerNatApeMaterno' => array(
					'label'       => 'Apellido materno',
					'value'       => '',
					'placeholder' => 'Apellido materno',
					),
				'dPerNacimiento' => array(
					'label'       => 'Fecha de nacimiento',
					'value'       => '',
					'placeholder' => 'Fecha de nacimiento',
					),
				'nPerNatSexo' => array(
					'label'   => 'Género',
					'value'   => '1',
					'options' => '',
					),
				'nPerNatEstCivil' => array(
					'label'   => 'Estado civil',
					'value'   => '1',
					'options' => '',
					),
				'direccion' => array(
					'label'              => 'Dirección',
					'cPerDirDescripcion' => array(
						'name'        => 'cPerDirDescripcion',
						'value'       => '',
						'label'       => 'Dirección',
						'placeholder' => 'Dirección',
						),
					),
				'documento' => array(
					'label'       => 'Documento de indentidad',
					'nPerDocTipo' => array(
						'label'       => 'Tipo',
						'name'        => 'nPerDocTipo',
						'value'       => '1',
						'placeholder' => 'Tipo',
						'options'     => '',
						),
					'cPerDocNumero' => array(
						'label'       => 'Número',
						'name'        => 'cPerDocNumero',
						'value'       => '',
						'placeholder' => 'Número',
						),
					),
				'telefono' => array(
					'label'         => 'Telefono',
					'cPerTelNumero' => array(
						'label'       => 'Número',
						'name'        => 'cPerTelNumero',
						'value'       => '',
						'placeholder' => 'Número',
						),
					),
				'email' => array(
					'label'    => 'Correo electrónico',
					'cPerMail' => array(
						'label'       => 'Correo',
						'name'        => 'cPerMail',
						'value'       => '',
						'placeholder' => 'Correo',
						),
					),
				),
'juridica' => array(
	'cPerNombre' => array(
		'label'       => 'Nombre',
		'value'       => '',
		'placeholder' => 'Nombre',
		'required'    => true,
		),
	'cPerJurDescripcion' => array(
		'label'       => 'Descripción',
		'value'       => '',
		'placeholder' => 'Descripción',
		),
	'nPerJurRubro' => array(
		'label'       => 'Rubro',
		'value'       => '1',
		'placeholder' => 'Rubro',
		'options'     => '',
		),
	'direccion' => array(
		'label'              => 'Dirección',
		'cPerDirDescripcion' => array(
			'label'       => 'Dirección',
			'name'        => 'cPerDirDescripcion',
			'value'       => '',
			'placeholder' => 'Dirección',
			),
		),
	'telefono' => array(
		'label'         => 'Telefono',
		'cPerTelNumero' => array(
			'label'       => 'Número',
			'name'        => 'cPerTelNumero',
			'value'       => '',
			'placeholder' => 'Teléfono',
			),
		),
	'email' => array(
		'label'    => 'Correo electrónico',
		'cPerMail' => array(
			'label'       => 'Correo electrónico',
			'name'        => 'cPerMail',
			'value'       => '',
			'placeholder' => 'Correo',
			),
		),
	),
),
);

private function dataFormulario($tipo) {
		// Sexos
	$sexos     = Parametro::buscarPorClase(1002);
	$dataSexos = array();

	foreach ($sexos as $sexo) {
		$arreglo['nombre'] = $sexo['cParDescripcion'];
		$arreglo['value']  = $sexo['nParCodigo'];

		array_push($dataSexos, $arreglo);
	}

	$this->dataFormulario['camposForm']['natural']['nPerNatSexo']['options'] = $dataSexos;

		// Estados civiles
	$estadoCivils     = Parametro::buscarPorClase(1000);
	$dataEstadoCivils = array();

	foreach ($estadoCivils as $estadoCivil) {
		$arreglo['nombre'] = $estadoCivil['cParDescripcion'];
		$arreglo['value']  = $estadoCivil['nParCodigo'];

		array_push($dataEstadoCivils, $arreglo);
	}

	$this->dataFormulario['camposForm']['natural']['nPerNatEstCivil']['options'] = $dataEstadoCivils;

		// Rubros
	$rubros     = Parametro::buscarPorClase(1005);
	$dataRubros = array();

	foreach ($rubros as $rubro) {
		$arreglo['nombre'] = $rubro['cParDescripcion'];
		$arreglo['value']  = $rubro['nParCodigo'];

		array_push($dataRubros, $arreglo);
	}

	$this->dataFormulario['camposForm']['juridica']['nPerJurRubro']['options'] = $dataRubros;

		// Tipos de documento
	$tipoDocumentos     = Parametro::buscarPorClase(1010);
	$dataTipoDocumentos = array();

	foreach ($tipoDocumentos as $tipoDocumento) {
		$arreglo['nombre'] = $tipoDocumento['cParDescripcion'];
		$arreglo['value']  = $tipoDocumento['nParCodigo'];

		array_push($dataTipoDocumentos, $arreglo);
	}

	$this->dataFormulario['camposForm']['natural']['documento']['nPerDocTipo']['options'] = $dataTipoDocumentos;

	if ($tipo == 'natural') {
		unset($this->dataFormulario['camposForm']['juridica']);
		for ($i = 0; $i < count($this->dataFormulario['tiposPersona']); $i++) {
			if ($this->dataFormulario['tiposPersona'][$i]['key'] == 'juridica') {
				unset($this->dataFormulario['tiposPersona'][$i]);
			}
		}

	} elseif ($tipo == 'juridica') {
		$this->dataFormulario['tipoPersona'] = 'juridica';

		unset($this->dataFormulario['camposForm']['natural']);
		for ($i = 0; $i < count($this->dataFormulario['tiposPersona']); $i++) {
			if ($this->dataFormulario['tiposPersona'][$i]['key'] == 'natural') {
				unset($this->dataFormulario['tiposPersona'][$i]);
			}
		}
	}

	return $this->dataFormulario;
}

private $camposVista = array(
	array(
		'titulo' => 'Nombre',
		'nombre' => 'cPerNombre',
		'type'   => 'text',
		),
	array(
		'titulo' => 'Dirección',
		'nombre' => 'cPerDirDescripcion',
		'type'   => 'text',
		),
	array(
		'titulo' => 'Documento',
		'nombre' => 'cPerDocNumero',
		'type'   => 'text',
		),
	array(
		'titulo' => 'Teléfono',
		'nombre' => 'cPerTelNumero',
		'type'   => 'text',
		),
	array(
		'titulo' => 'Correo',
		'nombre' => 'cPerMail',
		'type'   => 'text',
		),
	);

	/////////////////////////////////////////////////////
	// ---------------MÉTODOS PÚBLICOS--------------- //
	/////////////////////////////////////////////////////

	/**
	 * [Busca y envía los datos de la vista en formato json]
	 * @return [json] [Todos los datos de la vista]
	 */
	public function inicio() {
		// Botonera
		$nPerTipo         = 1;
		$nPerEstado       = 0;
		$nPerUsuEstado    = 0;
		$nPerUsuAccEstado = 0;
		$nParClase        = 5001;
		$cPerCodigo       = 1;
		$nPerUsuAccGrupo  = 1001;
		$nParTipo         = 1;
		$nParSrcClase     = 5000;
		$nParSrcCodigo    = 100101;

		$dbBotonera = DB::select("CALL usp_Get_Permisos_Botonera_By_Usuario('$nPerTipo', '$nPerEstado', '$nPerUsuEstado', '$nPerUsuAccEstado', '$nParClase', '$cPerCodigo', '$nPerUsuAccGrupo', '$nParTipo', '$nParSrcClase', '$nParSrcCodigo');");

		$dataBotonera = array();

		for ($i = 0; $i < count($dbBotonera); $i++) {
			$fila = $dbBotonera[$i];

			foreach ($fila as $property => $value) {
				if (HELPERS::isJSON($value)) {
					$dataBotonera[$i][$property] = json_decode($value);
				} else {
					$dataBotonera[$i][$property] = $value;
				}
			}
		}

		// Registros
		$nOriReg            = 0;
		$nCanReg            = $this->nCanReg;
		$nPagRegistro       = 1;
		$cPerNombre         = '';
		$cPerDirDescripcion = '';
		$cPerDocNumero      = '';
		$cPerTelNumero      = '';
		$cPerMail           = '';

		$dataRegistros = Persona::filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail);
		$dataRegistros = $this->completarRegistros($dataRegistros, 1);

		// Total de registros
		$nPagRegistro       = 0;
		$dataTodosRegistros = Persona::filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail);
		$totalRegistros     = count($dataTodosRegistros);
		$nCanPaginas        = ceil($totalRegistros / $this->nCanReg);

		// Paginador
		$dataPaginador = HELPERS::getPaginador($nCanPaginas, 1);

		// Rutas
		$dataRutas = array(
			'agregar' => URL::route('personasAgregar'),
			'editar'  => array(
				'url' => URL::route('personasEditar', array(
					'cPerCodigo' => '-p-cPerCodigo',
					)
				),
				'parametros' => array('cPerCodigo'),
				),
			'eliminar' => array(
				'url' => URL::route('personasEliminar', array(
					'cPerCodigo' => '-p-cPerCodigo',
					)
				),
				'parametros' => array('cPerCodigo'),
				),
			'filtrar' => URL::route('personasFiltrar'),
			);

		$data = array(
			'dataBotonera'    => $dataBotonera,
			'dataRegistros'   => $dataRegistros,
			'dataPaginador'   => $dataPaginador,
			'dataRutas'       => $dataRutas,
			'dataCamposVista' => $this->camposVista,
			'totalRegistros'  => $totalRegistros,
			);

		return json_encode($data);
	}

	/**
	 * [Busca los y envía los registros]
	 * @return [json] [Registros en formato json]
	 */
	public function filtrar() {
		$pagina             = Input::get('pagina');
		$cPerNombre         = Input::get('camposBusqueda.cPerNombre');
		$cPerDirDescripcion = Input::get('camposBusqueda.cPerDirDescripcion');
		$cPerDocNumero      = Input::get('camposBusqueda.cPerDocNumero');
		$cPerTelNumero      = Input::get('camposBusqueda.cPerTelNumero');
		$cPerMail           = Input::get('camposBusqueda.cPerMail');

		$pagina             = ($pagina === null) ? '' : $pagina;
		$cPerNombre         = ($cPerNombre === null) ? '' : $cPerNombre;
		$cPerDirDescripcion = ($cPerDirDescripcion === null) ? '' : $cPerDirDescripcion;
		$cPerDocNumero      = ($cPerDocNumero === null) ? '' : $cPerDocNumero;
		$cPerTelNumero      = ($cPerTelNumero === null) ? '' : $cPerTelNumero;
		$cPerMail           = ($cPerMail === null) ? '' : $cPerMail;

		// Registros
		$nCanReg      = $this->nCanReg;
		$nOriReg      = ($pagina - 1) * $nCanReg;
		$nPagRegistro = 1;

		$dataRegistros = Persona::filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail);
		$dataRegistros = $this->completarRegistros($dataRegistros, $pagina);

		// Total de registros
		$nPagRegistro       = 0;
		$dataTodosRegistros = Persona::filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail);
		$totalRegistros     = count($dataTodosRegistros);
		$nCanPaginas        = ceil($totalRegistros / $this->nCanReg);

		// Paginador
		$dataPaginador = HELPERS::getPaginador($nCanPaginas, $pagina);

		$data = array(
			'dataRegistros'  => $dataRegistros,
			'dataPaginador'  => $dataPaginador,
			'totalRegistros' => $totalRegistros,
			);

		return json_encode($data);
	}

	/**
	 * [Guardo un nuevo registro]
	 * @return [json] [Respuesta en formato json]
	 */
	public function data($cPerCodigo = null) {
		if (Request::isMethod('get')) {
			if ($cPerCodigo) {
				$persona = Persona::buscar($cPerCodigo);
				$persona = reset($persona);

				$perDireccion = PerDireccion::buscar($cPerCodigo);
				$perDireccion = reset($perDireccion);

				$perTelefono = PerTelefono::buscar($cPerCodigo);
				$perTelefono = reset($perTelefono);

				$perMail = PerMail::buscar($cPerCodigo);
				$perMail = reset($perMail);

				if ($persona['nPerTipo'] == 1) {
					$dataFormulario = $this->dataFormulario('natural');
					$campos         = $dataFormulario['camposForm']['natural'];

					$perDocumento = PerDocumento::buscar($cPerCodigo);
					$perDocumento = reset($perDocumento);

					$perNatural = PerNatural::buscar($cPerCodigo);
					$perNatural = reset($perNatural);

					$campos['cPerNombre']['value']        = $persona['cPerNombre'];
					$campos['cPerNatApePaterno']['value'] = $perNatural['cPerNatApePaterno'];
					$campos['cPerNatApeMaterno']['value'] = $perNatural['cPerNatApeMaterno'];
					$campos['dPerNacimiento']['value']    = $persona['dPerNacimiento'];
					$campos['nPerNatSexo']['value']       = $perNatural['nPerNatSexo'];
					$campos['nPerNatEstCivil']['value']   = $perNatural['nPerNatEstCivil'];

					if ($perDocumento) {
						$campos['documento']['nPerDocTipo']['value']        = $perDocumento['nPerDocTipo'];
						$campos['documento']['cPerDocNumero']['value']      = $perDocumento['cPerDocNumero'];
					}
					if ($perDireccion) {
						$campos['direccion']['cPerDirDescripcion']['value'] = $perDireccion['cPerDirDescripcion'];
					}
					if ($perTelefono) {
						$campos['telefono']['cPerTelNumero']['value']       = $perTelefono['cPerTelNumero'];
					}
					if ($perMail) {
						$campos['email']['cPerMail']['value']               = $perMail['cPerMail'];
					}

					$dataFormulario['camposForm']['natural'] = $campos;

				} elseif ($persona['nPerTipo'] == 2) {
					$dataFormulario = $this->dataFormulario('juridica');
					$campos         = $dataFormulario['camposForm']['juridica'];

					$perJuridica = PerJuridica::buscar($cPerCodigo);
					$perJuridica = reset($perJuridica);

					$campos['cPerNombre']['value']         = $persona['cPerNombre'];
					$campos['cPerJurDescripcion']['value'] = $perJuridica['cPerJurDescripcion'];
					$campos['nPerJurRubro']['value']       = $perJuridica['nPerJurRubro'];

					$campos['direccion']['cPerDirDescripcion']['value'] = $perDireccion['cPerDirDescripcion'];
					$campos['telefono']['cPerTelNumero']['value']       = $perTelefono['cPerTelNumero'];
					$campos['email']['cPerMail']['value']               = $perMail['cPerMail'];

					$dataFormulario['camposForm']['juridica'] = $campos;
				}

				$data = array(
					'dataFormulario' => $dataFormulario,
					);

			} else {
				$data = array(
					'dataFormulario' => $this->dataFormulario('all'),
					);
			}

			return json_encode($data);

		} elseif (Request::isMethod('post')) {
			$tipoPersona = Input::get('tipoPersona');

			if ($tipoPersona == 'natural') {
				// Obtengo los datos

				// Persona
				$cPerNombre     = Input::get('camposForm.natural.cPerNombre.value');
				$dPerNacimiento = Input::get('camposForm.natural.dPerNacimiento.value');

				$timestamp = strtotime($dPerNacimiento);
				$dPerNacimiento = date('Y-m-d',$timestamp);

				// Persona Natural
				$cPerNatApePaterno = Input::get('camposForm.natural.cPerNatApePaterno.value');
				$cPerNatApeMaterno = Input::get('camposForm.natural.cPerNatApeMaterno.value');
				$nPerNatSexo       = Input::get('camposForm.natural.nPerNatSexo.value');
				$nPerNatEstCivil   = Input::get('camposForm.natural.nPerNatEstCivil.value');

				// Documento
				$documento     = Input::get('camposForm.natural.documento');
				$nPerDocTipo   = $documento['nPerDocTipo']['value'];
				$cPerDocNumero = $documento['cPerDocNumero']['value'];

				// Dirección
				$direccion          = Input::get('camposForm.natural.direccion');
				$cPerDirDescripcion = $direccion['cPerDirDescripcion']['value'];

				// Teléfono
				$telefono      = Input::get('camposForm.natural.telefono');
				$cPerTelNumero = $telefono['cPerTelNumero']['value'];

				// Email
				$email    = Input::get('camposForm.natural.email');
				$cPerMail = $email['cPerMail']['value'];

				// Adicionales
				$cPerApellidos = $cPerNatApePaterno . ' ' . $cPerNatApeMaterno;
				$nPerEstado    = 1;

				// Verifico si es un nuevo registro o una actualización
				if ($cPerCodigo) {
					Persona::actualizar($cPerCodigo, $cPerNombre, $cPerApellidos, $dPerNacimiento, $nPerEstado);
					PerNatural::actualizar($cPerCodigo, $cPerNatApePaterno, $cPerNatApeMaterno, $nPerNatSexo, $nPerNatEstCivil);

				} else {
					// Persona
					$nPerTipo   = 1;
					$newPersona = Persona::registrar($cPerNombre, $cPerApellidos, $dPerNacimiento, $nPerTipo, $nPerEstado);
					$newPersona = reset($newPersona);
					$cPerCodigo = $newPersona['cPerCodigo'];

					// Persona natural
					PerNatural::registrar($cPerCodigo, $cPerNatApePaterno, $cPerNatApeMaterno, $nPerNatSexo, $nPerNatEstCivil);
				}

				// Documento
				$dPerDocCaducidad = '';
				$nPerDocCategoria = '';
				if (count(PerDocumento::buscar($cPerCodigo)) > 0) {
					if ($cPerDocNumero != '') {
						PerDocumento::actualizar($cPerCodigo, $nPerDocTipo, $cPerDocNumero);
					} else {
						PerDocumento::eliminar($cPerCodigo);
					}

				} elseif ($cPerDocNumero != '') {
					PerDocumento::registrar($cPerCodigo, $nPerDocTipo, $cPerDocNumero, $dPerDocCaducidad, $nPerDocCategoria);
				}

				// Dirección
				$nPerDirTipo   = 1;
				$nPerDirEstado = 1;
				if (count(PerDireccion::buscar($cPerCodigo)) > 0) {
					if ($cPerDirDescripcion != '') {
						PerDireccion::actualizar($cPerCodigo, $cPerDirDescripcion, $nPerDirTipo);
					} else {
						PerDireccion::eliminar($cPerCodigo);
					}

				} elseif ($cPerDirDescripcion != '') {
					PerDireccion::registrar($cPerCodigo, $cPerDirDescripcion, $nPerDirTipo, $nPerDirEstado);
				}

				// Teléfono
				$nPerTelTipo = '';
				if (count(PerTelefono::buscar($cPerCodigo)) > 0) {
					if ($cPerTelNumero != '') {
						PerTelefono::actualizar($cPerCodigo, $nPerTelTipo, $cPerTelNumero);
					} else {
						PerTelefono::eliminar($cPerCodigo);
					}

				} elseif ($cPerTelNumero != '') {
					PerTelefono::registrar($cPerCodigo, $nPerTelTipo, $cPerTelNumero);
				}

				// Email
				if (count(PerMail::buscar($cPerCodigo)) > 0) {
					if ($cPerMail != '') {
						PerMail::actualizar($cPerCodigo, $cPerMail);
					} else {
						PerMail::eliminar($cPerCodigo);
					}

				} elseif ($cPerMail != '') {
					PerMail::registrar($cPerCodigo, $cPerMail);
				}


			} elseif ($tipoPersona == 'juridica') {
				// Obtengo los datos

				// Persona Jurídica
				$cPerJurDescripcion = Input::get('camposForm.juridica.cPerJurDescripcion.value');
				$nPerJurRubro       = Input::get('camposForm.juridica.nPerJurRubro.value');
				$cPerNombre         = Input::get('camposForm.juridica.cPerNombre.value');
				$nPerEmpresa        = $cPerNombre;

				// Dirección
				$direccion          = Input::get('camposForm.juridica.direccion');
				$cPerDirDescripcion = $direccion['cPerDirDescripcion']['value'];

				// Teléfono
				$telefono      = Input::get('camposForm.juridica.telefono');
				$cPerTelNumero = $telefono['cPerTelNumero']['value'];

				// Email
				$email    = Input::get('camposForm.juridica.email');
				$cPerMail = $email['cPerMail']['value'];

				// Adicionales
				$cPerApellidos  = '';
				$dPerNacimiento = '';
				$nPerTipo       = 2;
				$nPerEstado     = 1;

				// Verifico si es un nuevo registro o una actualización
				if ($cPerCodigo) {
					Persona::actualizar($cPerCodigo, $cPerNombre, $cPerApellidos, $dPerNacimiento, $nPerEstado);
					PerJuridica::actualizar($cPerCodigo, $cPerJurDescripcion, $nPerEmpresa, $nPerJurRubro);

					$nPerDirTipo = 1;
					PerDireccion::actualizar($cPerCodigo, $cPerDirDescripcion, $nPerDirTipo);

					$nPerTelTipo = '';
					PerTelefono::actualizar($cPerCodigo, $nPerTelTipo, $cPerTelNumero);

					PerMail::actualizar($cPerCodigo, $cPerMail);

				} else {
					// Persona
					$newPersona = Persona::registrar($cPerNombre, $cPerApellidos, $dPerNacimiento, $nPerTipo, $nPerEstado);
					$newPersona = reset($newPersona);
					$cPerCodigo = $newPersona['cPerCodigo'];

					// Persona jurídica
					PerJuridica::registrar($cPerCodigo, $cPerJurDescripcion, $nPerEmpresa, $nPerJurRubro);

					// Dirección
					$nPerDirTipo   = 1;
					$nPerDirEstado = 1;
					PerDireccion::registrar($cPerCodigo, $cPerDirDescripcion, $nPerDirTipo, $nPerDirEstado);

					// Teléfono
					$nPerTelTipo = '';
					PerTelefono::registrar($cPerCodigo, $nPerTelTipo, $cPerTelNumero);

					// Email
					PerMail::registrar($cPerCodigo, $cPerMail);
				}
			}

			// Registros
			$nOriReg            = 0;
			$nCanReg            = $this->nCanReg;
			$nPagRegistro       = 1;
			$cPerNombre         = '';
			$cPerDirDescripcion = '';
			$cPerDocNumero      = '';
			$cPerTelNumero      = '';
			$cPerMail           = '';

			$dataRegistros = Persona::filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail);
			$dataRegistros = $this->completarRegistros($dataRegistros, 1);

			// Total de registros
			$nPagRegistro       = 0;
			$dataTodosRegistros = Persona::filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail);
			$totalRegistros     = count($dataTodosRegistros);
			$nCanPaginas        = ceil($totalRegistros / $this->nCanReg);

			// Paginador
			$dataPaginador = HELPERS::getPaginador($nCanPaginas, 1);

			$data = array(
				'dataRegistros'  => $dataRegistros,
				'dataPaginador'  => $dataPaginador,
				'totalRegistros' => $totalRegistros,
				);

			return json_encode($data);
		}
	}

	public function eliminar($cPerCodigo) {
		$nParEstado = 0;

		$updnParCodigo = Persona::eliminar($cPerCodigo);

		// Registros
		$nOriReg            = 0;
		$nCanReg            = $this->nCanReg;
		$nPagRegistro       = 1;
		$cPerNombre         = '';
		$cPerDirDescripcion = '';
		$cPerDocNumero      = '';
		$cPerTelNumero      = '';
		$cPerMail           = '';

		$dataRegistros = Persona::filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail);
		$dataRegistros = $this->completarRegistros($dataRegistros, 1);

		// Total de registros
		$nPagRegistro       = 0;
		$dataTodosRegistros = Persona::filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail);
		$totalRegistros     = count($dataTodosRegistros);
		$nCanPaginas        = ceil($totalRegistros / $this->nCanReg);

		// Paginador
		$dataPaginador = HELPERS::getPaginador($nCanPaginas, 1);

		$data = array(
			'dataRegistros'  => $dataRegistros,
			'dataPaginador'  => $dataPaginador,
			'totalRegistros' => $totalRegistros,
			);

		return json_encode($data);
	}

	/////////////////////////////////////////////////////
	// ---------------MÉTODOS INTERNOS--------------- //
	/////////////////////////////////////////////////////

	private function completarRegistros($dataRegistros, $pagina) {
		for ($i = 0; $i < count($dataRegistros); $i++) {
			$dataRegistros[$i]['index'] = ($this->nCanReg * ($pagina - 1)) + $i + 1;

			if ($dataRegistros[$i]['nPerTipo'] == 1) {
				$dataRegistros[$i]['cPerNombre'] = $dataRegistros[$i]['cPerNombre'] . ' ' . $dataRegistros[$i]['cPerApellidos'];
			}
		}

		return $dataRegistros;
	}
}
?>