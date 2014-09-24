<?php
class PerUsuario extends Eloquent {
	protected $table = 'perusuario';

	public static function registrar($cPerCodigo, $cPerUsuCodigo, $cPerUsuClave) {
		$query = "CALL usp_Set_PerUsuario('$cPerCodigo', '$cPerUsuCodigo', '$cPerUsuClave')";
		return DB::statement($query);
	}
}
?>