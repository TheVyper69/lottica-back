<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Clients extends Model
{
    protected $table = 'clients';


    protected $fillable = [
        'first_name',
        'last_name',
        'age',
        'email',
        'phone',
        'address',
        'birthdate',
        'gender',
        'occupation',
    ];
}
