HOW TO USE (Exam-ready Employees CRUD with Laravel)

0) Prereqs: PHP 8.x, Composer, SQLite or MySQL, Node optional.

1) Create a fresh Laravel app:
   composer create-project laravel/laravel employees_crud
   cd employees_crud

2) Copy everything from this ZIP into your Laravel project root, respecting folders:
   - app/
   - database/migrations/
   - database/seeders/
   - resources/views/employees/
   - routes/web.php (replace or merge with your existing routes/web.php)

3) Database
   Quickest: use SQLite for the exam.
   - In your project root: touch database/database.sqlite (create empty file)
   - In .env set:
       DB_CONNECTION=sqlite
       DB_DATABASE=./database/database.sqlite

   (If using MySQL instead, set DB_* in .env accordingly.)

4) Migrate + (optional) seed
   php artisan migrate
   php artisan db:seed --class=EmployeeSeeder   # optional sample data

5) Enable public storage for images
   php artisan storage:link

6) Serve
   php artisan serve
   Visit http://127.0.0.1:8000  -> it redirects to /employees

7) What to screenshot for the exam:
   - Index page listing employees (after seeding or after you add some)
   - Create form with validation errors (try empty Age or a non-integer; upload a non-image to see image validation)
   - Success message after adding/updating:
     * "Employee created successfully!"
     * "The Employee record update successfully"

Notes:
- Columns strictly follow the exam: EmpNo, Name, Age (integer), Department, Salary (numeric), image (file).
- Image uploads saved to storage/app/public/employees; displayed via /storage/... after running storage:link.
- Delete will also remove the stored image if exists.
