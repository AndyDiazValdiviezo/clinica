<?php
class Resultado extends Eloquent {
  protected $table = 'resultado';

  public static function buscar($cPerCodigo) {
    $query = "CALL usp_Get_Resultado_By_nPerCodigo('$cPerCodigo')";
    return HELPERS::stdArrayToArray(DB::select($query));
  }

  public static function filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail) {
    $query = "CALL usp_Filtrar_Resultado('$nOriReg', '$nCanReg', '$nPagRegistro', '$cPerNombre', '$cPerDirDescripcion', '$cPerDocNumero', '$cPerTelNumero', '$cPerMail')";
    return HELPERS::stdArrayToArray(DB::select($query));
  }

  public static function registrar($cPerNombre, $cPerApellidos, $dPerNacimiento, $nPerTipo, $nPerEstado) {
    $query = "CALL usp_Set_Resultado('$cPerNombre', '$cPerApellidos', '$dPerNacimiento', '$nPerTipo', '$nPerEstado')";
    return HELPERS::stdArrayToArray(DB::select($query));
  }

  public static function actualizar($cPerCodigo, $cPerApellidos, $cPerNombre, $dPerNacimiento, $nPerEstado) {
    $query = "CALL usp_Upd_Resultado('$cPerCodigo', '$cPerApellidos', '$cPerNombre', '$dPerNacimiento', '$nPerEstado')";
    return DB::statement($query);
  }

  public static function eliminar($cPerCodigo) {
    $query = "CALL usp_Del_Resultado('$cPerCodigo')";
    return DB::statement($query);
  }
}
?>