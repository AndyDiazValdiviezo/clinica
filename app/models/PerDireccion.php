<?php
class PerDireccion extends Eloquent {
	protected $table = 'perdireccion';

	public static function buscar($cPerCodigo) {
		$query = "CALL usp_Get_PerDireccion_By_nPerCodigo('$cPerCodigo')";
		return HELPERS::stdArrayToArray(DB::select($query));
	}

	public static function registrar($cPerCodigo, $cPerDirDescripcion, $nPerDirTipo, $nPerDirEstado) {
		$query = "CALL usp_Set_PerDireccion('$cPerCodigo', '$cPerDirDescripcion', '$nPerDirTipo', '$nPerDirEstado')";
		return DB::statement($query);
	}

	public static function actualizar($cPerCodigo, $cPerDirDescripcion, $nPerDirTipo) {
		$query = "CALL usp_Upd_PerDireccion('$cPerCodigo', '$cPerDirDescripcion', $nPerDirTipo)";
		return DB::statement($query);
	}

	public static function eliminar($cPerCodigo) {
		$query = "CALL usp_Del_PerDireccion('$cPerCodigo')";
		return DB::statement($query);
	}
}
?>