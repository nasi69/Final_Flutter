<?php

namespace App\Http\Controllers;

use App\Models\Member;
use Illuminate\Http\Request;

class MemberController extends Controller
{
    public function index()
    {
        return response()->json(Member::orderByDesc('id')->get());
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string|max:255',
            'tel'  => 'required|string|max:20',
            'type' => 'required|string|max:20',
        ]);

        $member = Member::create($data);
        return response()->json($member, 201);
    }

    public function show(Member $member)
    {
        return response()->json($member);
    }

    public function update(Request $request, Member $member)
    {
        $data = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'tel'  => 'sometimes|required|string|max:20',
            'type' => 'sometimes|required|string|max:20',
        ]);

        $member->update($data);
        return response()->json($member);
    }

    public function destroy(Member $member)
    {
        $member->delete();
        return response()->json(null, 204);
    }
}
