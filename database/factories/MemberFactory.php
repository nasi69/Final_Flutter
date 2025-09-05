<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class MemberFactory extends Factory
{
    public function definition(): array
    {
        return [
            'name' => $this->faker->name(),
            'tel'  => $this->faker->numerify('0#########'),
            'type' => $this->faker->randomElement(['regular','vip','staff']),
        ];
    }
}
