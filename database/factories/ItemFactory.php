<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

// /
//  * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Item>
//  */
class ItemFactory extends Factory
{
    // /
    //  * Define the model's default state.
    //  *
    //  * @return array<string, mixed>
    //  */
    public function definition(): array
    {
        return [
        'title' => fake()->sentence(),                // ✅ single string
        'price' => fake()->randomFloat(2, 1, 100),   // ✅ float between 1 and 100
        'qty' => fake()->numberBetween(1, 100),      // ✅ integer
        'in_stock' => fake()->boolean(),             // ✅ boolean
        'image' => 'pos3.jpg',
    ];
    }
}
