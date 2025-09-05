<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Todos;
class TodoController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $items = Todos::orderBy('id', 'asc')->paginate(20);
        return response()->json($items, 200);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'title'       => 'required|string|max:255',
            'description' => 'nullable|string',
            'completed'   => 'boolean',
        ]);
        
        $todo = Todos::create($validated);
        return response()->json($todo, 201);
    }

    /**
     * Display the specified todo.
     */
    public function show($id)
    {
        $todo = Todos::find($id);
        if (!$todo) {
            return response()->json(['message' => 'Todo not found'], 404);
        }

        return response()->json($todo, 200);
    }

    /**
     * Update the specified todo in storage.
     */
    public function update(Request $request, $id)
    {
        $todo = Todos::find($id);
        if (!$todo) {
            return response()->json(['message' => 'Todo not found'], 404);
        }

        $validated = $request->validate([
            'title'       => 'sometimes|required|string|max:255',
            'description' => 'sometimes|nullable|string',
            'completed'   => 'sometimes|boolean',
        ]);

        $todo->update($validated);
        return response()->json($todo, 200);
    }

    /**
     * Remove the specified todo from storage.
     */
    public function destroy($id)
    {
        $todo = Todos::find($id);
        if (!$todo) {
            return response()->json(['message' => 'Todo not found'], 404);
        }

        $todo->delete();
        return response()->json(['message' => 'Todo deleted successfully'], 200);
    }
}
