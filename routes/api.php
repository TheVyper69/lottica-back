<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\UserController;
use App\Http\Controllers\ClientsController;
use App\Http\Controllers\ProductController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::post('registro', [UserController::class, 'registroOftalmologo']);
Route::post('login', [UserController::class, 'login']);
Route::post('sesion', [UserController::class, 'sesion']);
Route::get('todo', [UserController::class, 'todo']);

//CLIENTES
Route::post('registroClients', [ClientsController::class, 'registroClients']);
Route::get('allClients', [ClientsController::class, 'allClients']);
Route::get('allClients/{id}',   [ClientsController::class, 'showClient']);
Route::delete('delete/{id}', [ClientsController::class, 'destroy']);
Route::put('updateClient/{id}', [ClientsController::class, 'update']);

//product
Route::post('registroPruduct', [ProductController::class, 'store']);
Route::get('showBrand', [ProductController::class, 'showBrand']);
Route::get('showCategoria', [ProductController::class, 'showCategoria']);







