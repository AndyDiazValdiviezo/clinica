<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the Closure to execute when that URI is requested.
|
 */

Route::get('/', 'InicioController@showInicio');

Route::get('/tablas-maestras/colors', array(
		'as'   => 'colors',
		'uses' => 'ColorController@inicioJson',
	));

Route::post('/tablas-maestras/colors/filtrar', array(
		'as'   => 'colorsFiltrar',
		'uses' => 'ColorController@filtrarJson',
	));

Route::post('/tablas-maestras/colors/agregar', array(
		'as'   => 'colorsAgregar',
		'uses' => 'ColorController@agregarJson',
	));

Route::post('/tablas-maestras/colors/editar', array(
		'as'   => 'colorsEditar',
		'uses' => 'ColorController@editarJson',
	));

Route::post('/tablas-maestras/colors/eliminar', array(
		'as'   => 'colorsEliminar',
		'uses' => 'ColorController@eliminarJson',
	));
