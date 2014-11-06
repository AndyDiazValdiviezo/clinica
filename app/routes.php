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

////////////////////////////////
// ----------INICIO---------- //
////////////////////////////////
Route::get('/', 'InicioController@inicio');

//////////////////////////////////
// ----------PERSONAS---------- //
//////////////////////////////////
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

///////////////////////////////////
// ----------RESULTADOS--------- //
///////////////////////////////////

Route::get('/laboratorios/resultados', array(
	'as'   => 'resultados',
	'uses' => 'ResultadoController@inicio',
));
