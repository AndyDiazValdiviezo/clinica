<?php
class Persona extends Eloquent {
	protected $table = 'persona';

	public static function buscar($cPerCodigo) {
		$query = "CALL usp_Get_Persona_By_nPerCodigo('$cPerCodigo')";
		return HELPERS::stdArrayToArray(DB::select($query));
	}

	public static function filtrar($nOriReg, $nCanReg, $nPagRegistro, $cPerNombre, $cPerDirDescripcion, $cPerDocNumero, $cPerTelNumero, $cPerMail) {
		$query = "CALL usp_Filtrar_Persona('$nOriReg', '$nCanReg', '$nPagRegistro', '$cPerNombre', '$cPerDirDescripcion', '$cPerDocNumero', '$cPerTelNumero', '$cPerMail')";
		return HELPERS::stdArrayToArray(DB::select($query));
	}

	public static function registrar($cPerNombre, $cPerApellidos, $dPerNacimiento, $nPerTipo, $nPerEstado) {
		$query = "CALL usp_Set_Persona('$cPerNombre', '$cPerApellidos', '$dPerNacimiento', '$nPerTipo', '$nPerEstado')";
		return HELPERS::stdArrayToArray(DB::select($query));
	}

	public static function actualizar($cPerCodigo, $cPerApellidos, $cPerNombre, $dPerNacimiento, $nPerEstado) {
		$query = "CALL usp_Upd_Persona('$cPerCodigo', '$cPerApellidos', '$cPerNombre', '$dPerNacimiento', '$nPerEstado')";
		return DB::statement($query);
	}

	public static function eliminar($cPerCodigo) {
		$query = "CALL usp_Del_Persona('$cPerCodigo')";
		return DB::statement($query);
	}
}
?>