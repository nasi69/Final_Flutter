@extends('employees.layout')

@section('content')
    <div class="card">
        <h2 class="card-header">Laravel CRUD EMPLOYEES</h2>
        <div class="card-body">
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <a class="btn btn-success btn-sm" href="{{ route('employees.create') }}">
                    <i class="fa fa-plus"></i> Create New
                </a>
            </div>

            <table class="table table-bordered table-striped mt-4">
                <thead>
                <tr>
                    <th width="80px">EmployeeNo</th>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Department</th>
                    <th>Salary</th>
                    <th>Image</th>
                    <th width="250px">Action</th>
                </tr>
                </thead>
                <tbody>
                @forelse($employees as $employee)
                    <tr>
                        <td>{{ $employee->EmpNo }}</td>
                        <td>{{ $employee->Name }}</td>
                        <td>{{ $employee->Age }}</td>
                        <td>{{ $employee->Department }}</td>
                        <td>{{ number_format($employee->Salary, 2) }}</td>
                        <td>
                            @if($employee->image)
                                <img src="{{ asset('storage/'.$employee->image) }}" alt="img" width="60">
                            @endif
                        </td>
                        <td>
                            <a class="btn btn-info btn-sm" href="{{ route('employees.show', $employee->id) }}">
                                <i class="fa-solid fa-list"></i> Show
                            </a>
                            <a class="btn btn-primary btn-sm" href="{{ route('employees.edit', $employee->id) }}">
                                <i class="fa-solid fa-pen-to-square"></i> Edit
                            </a>
                            <form action="{{ route('employees.destroy', $employee->id) }}" method="POST" class="d-inline">
                                @csrf
                                @method('DELETE')
                                <button type="submit" class="btn btn-danger btn-sm">
                                    <i class="fa-solid fa-trash"></i> Delete
                                </button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="7" class="text-center">No employees yet.</td></tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>
@endsection
