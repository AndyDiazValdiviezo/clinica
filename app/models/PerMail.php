<?php
class PerMail extends Eloquent {
	protected $table = 'permail';

	public static function buscar($cPerCodigo) {
		$query = "CALL usp_Get_PerMail_By_nPerCodigo('$cPerCodigo')";
		return HELPERS::stdArrayToArray(DB::select($query));
	}

	public static function registrar($cPerCodigo, $cPerMail) {
		$query = "CALL usp_Set_PerMail('$cPerCodigo', '$cPerMail')";
		return DB::select($query);
	}

	public static function actualizar($cPerCodigo, $cPerMail) {
		$query = "CALL usp_Upd_PerMail('$cPerCodigo', '$cPerMail')";
		return DB::statement($query);
	}

	public static function eliminar($cPerCodigo) {
		$query = "CALL usp_Del_PerMail('$cPerCodigo')";
		return DB::statement($query);
	}
}
?>