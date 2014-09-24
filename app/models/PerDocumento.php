<?php
class PerDocumento extends Eloquent {
	protected $table = 'perdocumento';

	public static function buscar($cPerCodigo) {
		$query = "CALL usp_Get_PerDocumento_By_nPerCodigo('$cPerCodigo')";
		return HELPERS::stdArrayToArray(DB::select($query));
	}

	public static function registrar($cPerCodigo, $nPerDocTipo, $cPerDocNumero, $dPerDocCaducidad, $nPerDocCategoria) {
		$query = "CALL usp_Set_PerDocumento('$cPerCodigo', '$nPerDocTipo', '$cPerDocNumero', '$dPerDocCaducidad', '$nPerDocCategoria')";
		return DB::statement($query);
	}

	public static function actualizar($cPerCodigo, $nPerDocTipo, $cPerDocNumero) {
		$query = "CALL usp_Upd_PerDocumento('$cPerCodigo', '$nPerDocTipo', '$cPerDocNumero')";
		return DB::statement($query);
	}

	public static function eliminar($cPerCodigo) {
		$query = "CALL usp_Del_PerDocumento('$cPerCodigo')";
		return DB::statement($query);
	}
}
?>