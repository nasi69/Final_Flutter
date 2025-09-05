@extends('employees.layout')

@section('content')
<div class="row">
    <div class="col-12 col-md-8 col-lg-6 mx-auto">
        <div class="card">
            <h2 class="card-header">Edit Employee</h2>
            <div class="card-body">

                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a class="btn btn-primary btn-sm" href="{{ route('employees.index') }}">
                        <i class="fa fa-arrow-left"></i> Back
                    </a>
                </div>

                @if ($errors->any())
                    <div class="alert alert-danger mt-3">
                        <ul class="mb-0">
                            @foreach ($errors->all() as $error)
                                <li>{{ $error }}</li>
                            @endforeach
                        </ul>
                    </div>
                @endif

                <form action="{{ route('employees.update', $employee->id) }}" method="POST" enctype="multipart/form-data" class="mt-3">
                    @csrf
                    @method('PUT')

                    <div class="mb-3">
                        <label class="form-label"><strong>Employee Number</strong></label>
                        <input class="form-control" type="text" name="EmpNo" value="{{ old('EmpNo', $employee->EmpNo) }}" placeholder="EmployeeNumber">
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><strong>Name</strong></label>
                        <input class="form-control" type="text" name="Name" value="{{ old('Name', $employee->Name) }}" placeholder="Name">
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><strong>Age</strong></label>
                        <input class="form-control" type="number" name="Age" value="{{ old('Age', $employee->Age) }}" placeholder="Age">
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><strong>Department</strong></label>
                        <input class="form-control" type="text" name="Department" value="{{ old('Department', $employee->Department) }}" placeholder="Department">
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><strong>Salary</strong></label>
                        <input class="form-control" type="number" step="0.01" name="Salary" value="{{ old('Salary', $employee->Salary) }}" placeholder="Salary">
                    </div>

                    <div class="mb-3">
                        <label class="form-label"><strong>Image</strong></label>
                        <input class="form-control" type="file" name="image" accept="image/*">
                        @if($employee->image)
                            <div class="mt-2">
                                <img src="{{ asset('storage/'.$employee->image) }}" alt="img" width="80">
                            </div>
                        @endif
                    </div>

                    <button type="submit" class="btn btn-success">
                        <i class="fa-solid fa-floppy-disk"></i> Submit
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>
@endsection
