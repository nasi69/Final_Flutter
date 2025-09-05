<?php

use App\Http\Controllers\StudentController;
use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\Route;

Route::get(uri: '/', action:  function (): View {
    return view(view: 'welcome');
});

Route::get(uri: '/students', action: [StudentController::class, 'index']);
