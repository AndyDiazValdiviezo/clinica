<?php
class PerTelefono extends Eloquent {
	protected $table = 'pertelefono';

	public static function buscar($cPerCodigo) {
		$query = "CALL usp_Get_PerTelefono_By_nPerCodigo('$cPerCodigo')";
		return HELPERS::stdArrayToArray(DB::select($query));
	}

	public static function registrar($cPerCodigo, $nPerTelTipo, $cPerTelNumero) {
		$query = "CALL usp_Set_PerTelefono('$cPerCodigo', '$nPerTelTipo', '$cPerTelNumero')";
		return DB::select($query);
	}

	public static function actualizar($cPerCodigo, $nPerTelTipo, $cPerTelNumero) {
		$query = "CALL usp_Upd_PerTelefono('$cPerCodigo', '$nPerTelTipo', '$cPerTelNumero')";
		return DB::statement($query);
	}

	public static function eliminar($cPerCodigo) {
		$query = "CALL usp_Del_PerTelefono('$cPerCodigo')";
		return DB::statement($query);
	}
}
?>