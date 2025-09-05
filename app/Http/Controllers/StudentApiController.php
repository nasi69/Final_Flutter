<?php
 namespace App\Http\Controllers\Api;
    use App\Models\Student;
 use App\Http\Controllers\Controller;
 use Illuminate\Http\Request;
 class StudentApiController extends Controller{
    public function index()
    {
        //$students = Student:: paginate(10);
        //$students = Student::latest()->get();
        $students = Student::latest()->paginate(20);
        return $students;

    }
    public function store(Request $request){
        $validated = $request->validate(['name' => 'required|string']);
        $student = Student::create($validated);
        return response()->json($student, 201);
    }
   public function show($id){
        $student = Student::find($id);
        if (!$student) return response()->json(['message' => 'Not found'], 404);
        return $student;
    }
    public function update(Request $request, $id){
        $student = Student::find($id);
        if (!$student) return response()->json(['message' => 'Not found'], 404);
        $validated = $request->validate(['name' => 'required|string']);
        $student->update($validated);
        return response()->json($student);
    }
    public function destroy($id){
        $student = Student::find($id);
        if (!$student) return response()->json(['message' => 'Not found'], 404);
        $student->delete();
        return response()->json(['message' => 'Deleted']);
    }
 }
