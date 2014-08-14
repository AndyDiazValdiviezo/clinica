<?php

class InicioController extends BaseController {
	function showInicio() {
		$dataMenu = DB::select('Call usp_Get_Permisos_By_Usuario(1, 0, 0, 0, 1000, 1, 10);');

		$aMenus = array();

		foreach ($dataMenu as $key => $objFila) {
			$codigo   = $objFila->nPerUsuAccCodigo;
			$objPadre = $this->buscarPadre($dataMenu, $objFila);

			if ($objPadre) {
				$aMenus = $this->setHijoRecursivo($objFila, $objPadre->nPerUsuAccCodigo, $aMenus);
			} else {
				$aMenus[$codigo]['objeto'] = $objFila;
			}
		}

		$htmlMenu = $this->getHtmlMenu($aMenus);

		return View::make('inicio', array(
				'htmlMenu' => $htmlMenu,
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

	private function getHtmlMenu($menus) {
		$htmlMenu = '';

		foreach ($menus as $menu) {
			if (isset($menu['subMenus'])) {
				if (count($menu['subMenus']) > 0) {
					$htmlMenu .= '<div class="panel-group">';
					$htmlMenu .= '<div class="panel panel-default">';
					$htmlMenu .= '<div class="panel-heading" data-jerarquia="'.$menu['objeto']->CanJerarquia.'">';
					$htmlMenu .= '<h4 class="panel-title">';
					$htmlMenu .= '<a data-toggle="collapse" data-parent="#sidebar-menu" href="#cod-'.$menu['objeto']->nPerUsuAccCodigo.'" no-link-directive>';

					if (HELPERS::isJSON($menu['objeto']->cParNombre)) {
						$json = json_decode($menu['objeto']->cParNombre);

						if ($json->tipo == 'menu') {
							if (isset($json->icono)) {
								$htmlMenu .= '<span class="icono '.$json->icono->bsClase.' '.$json->icono->color.'"></span>';
							} else {
								$htmlMenu .= '<span class="icono invisible glyphicon glyphicon-minus"></span>';
							}
						}
					}

					$htmlMenu .= '<span class="nombre">'.$menu['objeto']->NombreMenu.'</span>';
					$htmlMenu .= '</a>';
					$htmlMenu .= '</h4>';
					$htmlMenu .= '</div>';
					$htmlMenu .= '<div id="cod-'.$menu['objeto']->nPerUsuAccCodigo.'" class="panel-collapse collapse">';
					$htmlMenu .= $this->getHtmlMenu($menu['subMenus']);
					$htmlMenu .= '</div>';
					$htmlMenu .= '</div>';
					$htmlMenu .= '</div>';
				}
			} else {
				$cParNombre = $menu['objeto']->cParNombre;
				$ruta       = '';
				if ($cParNombre != '') {
					$json = json_decode($cParNombre);
					$ruta = $json->nombreRuta;
				}

				$htmlMenu .= '<div class="panel-heading last" data-jerarquia="'.$menu['objeto']->CanJerarquia.'">';
				$htmlMenu .= '<h4 class="panel-title">';
				$htmlMenu .= '<a data-toggle="collapse" data-parent="#sidebar-menu" href="#cod-'.$menu['objeto']->nPerUsuAccCodigo.'" ng-click="go(\'#/'.$ruta.'\')" link-directive>';

				if (HELPERS::isJSON($menu['objeto']->cParNombre)) {
					$json = json_decode($menu['objeto']->cParNombre);

					if ($json->tipo == 'menu') {
						if (isset($json->icono)) {
							$htmlMenu .= '<span class="icono '.$json->icono->bsClase.' '.$json->icono->color.'"></span>';
						} else {
							$htmlMenu .= '<span class="icono invisible glyphicon glyphicon-minus"></span>';
						}
					}
				}

				$htmlMenu .= '<span class="nombre">'.$menu['objeto']->NombreMenu.'</span>';
				$htmlMenu .= '</a>';
				$htmlMenu .= '</h4>';
				$htmlMenu .= '</div>';
			}
		}

		return $htmlMenu;
	}
}
?>