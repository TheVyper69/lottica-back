<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class MedicalHistory extends Model
{
    use SoftDeletes;

    protected $table = 'medical_history';

    protected $fillable = [
        'client_id',
        'id_oftalmologo',
        'date',
        'reason',

        'hipertension',
        'hipertension_estado',
        'diabetes',
        'diabetes_estado',
        'catarata',

        'dolor_cabeza',
        'dolor_ocular',
        'cansancio_visual',
        'hiperemia',
        'epifora',
        'secrecion',

        'cejas_od','cejas_oi',
        'parpados_od','parpados_oi',
        'pestanas_od','pestanas_oi',
        'conjuntiva_od','conjuntiva_oi',
        'aparato_lagrimal_od','aparato_lagrimal_oi',
    ];

    protected $casts = [
        'date' => 'datetime',
        'dolor_cabeza'     => 'boolean',
        'dolor_ocular'     => 'boolean',
        'cansancio_visual' => 'boolean',
        'hiperemia'        => 'boolean',
        'epifora'          => 'boolean',
        'secrecion'        => 'boolean',
    ];
}
