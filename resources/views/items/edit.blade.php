<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Item</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
</head>
<body>
  <div class="container">
    <h1>Edit Item</h1>

    <input type="text" name="title" value="{{ $item->title }}" class="form-control mb-2" placeholder="Enter Title"
      required>
    <input type="number" name="price" value="{{ $item->price }}" class="form-control mb-2" placeholder="Enter Price"
      step="0.1" required>
    <input type="number" name="qty" value="{{ $item->qty }}" class="form-control mb-2"
      placeholder="Enter Quantity" required>
    <div class="form-check mb-2">
      <div class="mb-3">
        <div class="form-check">
          <input class="form-check-input" id="option1" type="radio" name="in_stock" value="1"
            @checked($item->in_stock == 1)>
          <label class="form-check-label" for="option1">In Stock</label>
        </div>
        <div class="form-check">
          <input class="form-check-input" id="option2" type="radio" name="in_stock" value="0"
            @checked($item->in_stock == 0)>
          <label class="form-check-label" for="option2">No Stock</label>
        </div>
      </div>
    </div>

    @if ($item->image)
      <div class="mb-2">
        <label>Current Image:</label><br><img src="{{ asset('storage/' . $item->image) }}" width="200">
      </div>
    @else
      No Image
    @endif
    <div class="mb-3"> <label>Upload New Image:</label> <input type="file" name="image" class="form-control">
    </div>
    <button class="btn btn-success">Update Product</button>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>

</body>
</html>
