<?php
class ResultadoController extends BaseController {
  private $nCanReg   = 10;
  private $nParClase = 1010;

  private $dataFormulario = array(
    'camposForm' => array(
      ),
    );

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

    $dataRegistros = Resultado::filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail);
    $dataRegistros = $this->completarRegistros($dataRegistros, 1);

    // Total de registros
    $nPagRegistro       = 0;
    $dataTodosRegistros = Resultado::filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail);
    $totalRegistros     = count($dataTodosRegistros);
    $nCanPaginas        = ceil($totalRegistros / $this->nCanReg);

    // Paginador
    $dataPaginador = HELPERS::getPaginador($nCanPaginas, 1);

    // Rutas
    $dataRutas = array(
      // 'agregar' => URL::route('resultadosAgregar'),
      // 'editar'  => array(
      //   'url' => URL::route('resultadosEditar', array(
      //     'cPerCodigo' => '-p-cPerCodigo',
      //     )
      //   ),
      //   'parametros' => array('cPerCodigo'),
      //   ),
      // 'eliminar' => array(
      //   'url' => URL::route('resultadosEliminar', array(
      //     'cPerCodigo' => '-p-cPerCodigo',
      //     )
      //   ),
      //   'parametros' => array('cPerCodigo'),
      //   ),
      // 'filtrar' => URL::route('resultadosFiltrar'),
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

  /////////////////////////////////////////////////////
  // ---------------MÉTODOS INTERNOS--------------- //
  /////////////////////////////////////////////////////

}
?>