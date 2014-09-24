<?php
class PerNatural extends Eloquent {
	protected $table = 'pernatural';

	public static function buscar($cPerCodigo) {
		$query = "CALL usp_Get_PerNatural_By_nPerCodigo('$cPerCodigo')";
		return HELPERS::stdArrayToArray(DB::select($query));
	}

	public static function registrar($cPerCodigo, $cPerNatApePaterno, $cPerNatApeMaterno, $nPerNatSexo, $nPerNatEstCivil) {
		$query = "CALL usp_Set_PerNatural('$cPerCodigo', '$cPerNatApePaterno', '$cPerNatApeMaterno', '$nPerNatSexo', '$nPerNatEstCivil')";
		return DB::statement($query);
	}

	public static function actualizar($cPerCodigo, $cPerNatApePaterno, $cPerNatApeMaterno, $nPerNatSexo, $nPerNatEstCivil) {
		$query = "CALL usp_Upd_PerNatural('$cPerCodigo', '$cPerNatApePaterno', '$cPerNatApeMaterno', '$nPerNatSexo', '$nPerNatEstCivil')";
		return DB::statement($query);
	}
}
?>