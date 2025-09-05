<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Items List</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
</head>

<body>
  <div class="container">
    <h1>Items List</h1>
    <a href="{{ route('items.create') }}" class="btn btn-primary">Add New</a>
    <table border="1px" class="table table-hover">
      <thead class="table table-primary">
        <tr>
          <th>ID</th>
          <th>Title</th>
          <th>Price</th>
          <th>Qty</th>
          <th>In Stock</th>
          <th>Image</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody class="table">
        @foreach ($items as $element)
          <tr>
            <td>{{ $element->id }}</td>
            <td>{{ $element->title }}</td>
            <td>{{ $element->price }}</td>
            <td>{{ $element->qty }}</td>
            <td>{{ $element->in_stock ? 'Yes' : 'No' }}</td>
            <td><img width="80" src="{{ asset('storage/' . $element->image) }}" alt=""></td>
            <td><a href="{{ route('items.edit', $element->id) }}" class="btn btn-sm btn-primary">Edit</a> <a href="http://"
                class="btn btn-sm btn-danger">Delete</a></td>
          </tr>
        @endforeach
      </tbody>
    </table>
    {{ $items->links('pagination::bootstrap-5') }}
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</body>

</html>
