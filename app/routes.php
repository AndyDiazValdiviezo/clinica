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

Route::get('/', 'InicioController@inicio');

Route::get('/tablas-maestras/personas', array(
	'as'   => 'personas',
	'uses' => 'PersonaController@inicio',
));

Route::post('/tablas-maestras/personas/filtrar', array(
	'as'   => 'personasFiltrar',
	'uses' => 'PersonaController@filtrar',
));

Route::match(array('GET', 'POST'), '/tablas-maestras/personas/agregar', array(
	'as'   => 'personasAgregar',
	'uses' => 'PersonaController@data',
));

Route::match(array('GET', 'POST'), '/tablas-maestras/personas/editar/{cPerCodigo}', array(
	'as'   => 'personasEditar',
	'uses' => 'PersonaController@data',
));

Route::get('/tablas-maestras/personas/eliminar/{cPerCodigo}', array(
	'as'   => 'personasEliminar',
	'uses' => 'PersonaController@eliminar',
));

Route::match(array('GET', 'POST'), '/tablas-maestras/colors/agregar', array(
	'as'   => 'colorsAgregar',
	'uses' => 'ColorController@jsonAgregar',
));

Route::match(array('GET', 'POST'), '/tablas-maestras/colors/editar/{nParCodigo}/{nParClase}', array(
	'as'   => 'colorsEditar',
	'uses' => 'ColorController@jsonEditar',
));

Route::get('/tablas-maestras/colors/eliminar/{nParCodigo}/{nParClase}', array(
	'as'   => 'colorsEliminar',
	'uses' => 'ColorController@jsonEliminar',
));
