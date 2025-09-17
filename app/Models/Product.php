<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Product extends Model
{
    use HasFactory, SoftDeletes;

    // Nombre de la tabla
    protected $table = 'products';

    // Campos que se pueden asignar masivamente
    protected $fillable = [
        'name',
        'category',
        'brand',
        'price',
        'stock',
        'date_added',
        'SN',
    ];

    // Cast de tipos de datos
    protected $casts = [
        'stock'      => 'integer',
        'date_added' => 'date:Y-m-d',
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
        'deleted_at' => 'datetime',
    ];
}
