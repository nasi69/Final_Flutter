<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\ItemApiController;
Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');
use App\Http\Controllers\Api\AuthController;
// use App\Http\Controllers\Api\StudentApiController;

// Route::apiResource('items', ItemApiController::class);
// use App\Http\Controllers\Api\FoodApiController;
// Route::apiResource('foods', FoodApiController::class);
// use App\Http\Controllers\Api\ProjectApiController;
// Route::apiResource('projects', ProjectApiController::class);

use App\Http\Controllers\Api\TodoController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');





Route::middleware('auth:sanctum')->group(function () {
    Route::apiResource('todos', TodoController::class);
    //Other routes
});

