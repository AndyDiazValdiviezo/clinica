<?php
class PerJuridica extends Eloquent {
	protected $table = 'pernatural';

	public static function buscar($cPerCodigo) {
		$query = "CALL usp_Get_PerJuridica_By_nPerCodigo('$cPerCodigo')";
		return HELPERS::stdArrayToArray(DB::select($query));
	}

	public static function registrar($cPerCodigo, $cPerJurDescripcion, $nPerEmpresa, $nPerJurRubro) {
		$query = "CALL usp_Set_PerJuridica('$cPerCodigo', '$cPerJurDescripcion', '$nPerEmpresa', '$nPerJurRubro')";
		return DB::statement($query);
	}

	public static function actualizar($cPerCodigo, $cPerJurDescripcion, $nPerEmpresa, $nPerJurRubro) {
		$query = "CALL usp_Upd_PerJuridica('$cPerCodigo', '$cPerJurDescripcion', '$nPerEmpresa', '$nPerJurRubro')";
		return DB::statement($query);
	}
}
?>