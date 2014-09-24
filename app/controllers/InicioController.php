<?php

class InicioController extends BaseController {
	function inicio() {
		$nPerTipo         = 1;
		$nPerEstado       = 0;
		$nPerUsuEstado    = 0;
		$nPerUsuAccEstado = 0;
		$nParClase        = 5000;
		$cPerCodigo       = 1;
		$nPerUsuAccGrupo  = 10;

		$dataMenu = DB::select("Call usp_Get_Permisos_By_Usuario('$nPerTipo', '$nPerEstado', '$nPerUsuEstado', '$nPerUsuAccEstado', '$nParClase', '$cPerCodigo', '$nPerUsuAccGrupo');");

		$aMenus = array();

		foreach ($dataMenu as $key => $objFila) {
			$objFila->ruta = URL::route('personas', array(), false);
			$codigo        = $objFila->nPerUsuAccCodigo;
			$objPadre      = $this->buscarPadre($dataMenu, $objFila);

			if ($objPadre) {
				$aMenus = $this->setHijoRecursivo($objFila, $objPadre->nPerUsuAccCodigo, $aMenus);
			} else {
				$aMenus[$codigo]['objeto'] = $objFila;
			}
		}

		$aMenus = $this->jsonStringToArray($aMenus);

		return View::make('index', array(
				'jsonMenus' => json_encode($aMenus),
			));
	}

	private function buscarPadre($array, $filaHijo) {
		$downCod = (string) $filaHijo->nPerUsuAccCodigo;

		foreach ($array as $key => $aFila) {
			$upCod = (string) $aFila->nPerUsuAccCodigo;

			if ($downCod != $upCod) {
				$condicion = (strpos($downCod, $upCod) || (strpos($downCod, $upCod) === 0)) && ((int) $filaHijo->CanJerarquia == (int) ($aFila->CanJerarquia+2));
				if ($condicion) {
					return $aFila;
				}
			}
		}

		return false;
	}

	private function setHijoRecursivo($filaHijo, $codPadre, $arreglo) {
		$codHijo = $filaHijo->nPerUsuAccCodigo;

		$comparation = array_key_exists($codPadre, $arreglo) && $codHijo != $codPadre;

		if ($comparation) {
			$arreglo[$codPadre]['subMenus'][$codHijo]['objeto'] = $filaHijo;
			return $arreglo;

		} else {
			foreach ($arreglo as $key => $item) {
				if (isset($item['subMenus'])) {
					if (count($item['subMenus']) > 0) {
						$item['subMenus'] = $this->setHijoRecursivo($filaHijo, $codPadre, $item['subMenus']);
						$arreglo[$key]    = $item;
						return $arreglo;
					}
				}
			}
		}

		return $arreglo;
	}

	private function jsonStringToArray($data) {
		foreach ($data as $key => $value) {
			if (is_array($data)) {
				if (is_array($data[$key]) || is_object($data[$key])) {
					$data[$key] = $this->jsonStringToArray($data[$key]);
				} else {
					if (HELPERS::isJSON($data[$key])) {
						$data[$key] = json_decode($data[$key]);
					}
				}
			}
			if (is_object($data)) {
				if (is_array($data->$key) || is_object($data->$key)) {
					$data->$key = $this->jsonStringToArray($data->$key);
				} else {
					if (HELPERS::isJSON($data->$key)) {
						$data->$key = json_decode($data->$key);
					}
				}
			}
		}

		return $data;
	}
}
?>
