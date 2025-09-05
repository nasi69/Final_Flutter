<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Employee>
 */
class EmployeeFactory extends Factory
{
    public function definition(): array
    {
        static $empNo = 1;

        return [
            'EmpNo' => 'E' . str_pad($empNo++, 3, '0', STR_PAD_LEFT),
            'Name' => $this->faker->name(),
            'Age' => $this->faker->numberBetween(20, 55),
            'Department' => $this->faker->randomElement(['HR', 'IT', 'Finance', 'Sales', 'Marketing']),
            'Salary' => $this->faker->randomFloat(2, 400, 2000),
            'image' => null, // can be updated later
        ];
    }
}
