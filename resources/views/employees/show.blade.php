@extends('employees.layout')

@section('content')
<div class="row">
    <div class="col-12 col-md-8 col-lg-6 mx-auto">
        <div class="card">
            <h2 class="card-header">Employee Detail</h2>
            <div class="card-body">
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a class="btn btn-primary btn-sm" href="{{ route('employees.index') }}">
                        <i class="fa fa-arrow-left"></i> Back
                    </a>
                </div>
                <ul class="list-group mt-3">
                    <li class="list-group-item"><strong>EmployeeNo:</strong> {{ $employee->EmpNo }}</li>
                    <li class="list-group-item"><strong>Name:</strong> {{ $employee->Name }}</li>
                    <li class="list-group-item"><strong>Age:</strong> {{ $employee->Age }}</li>
                    <li class="list-group-item"><strong>Department:</strong> {{ $employee->Department }}</li>
                    <li class="list-group-item"><strong>Salary:</strong> {{ number_format($employee->Salary, 2) }}</li>
                    <li class="list-group-item">
                        <strong>Image:</strong>
                        @if($employee->image)
                            <div class="mt-2">
                                <img src="{{ asset('storage/'.$employee->image) }}" width="120">
                            </div>
                        @else
                            <span>—</span>
                        @endif
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
@endsection
