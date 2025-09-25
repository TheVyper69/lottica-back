<?php

namespace App\Http\Controllers;

use App\Models\MedicalHistory;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class MedicalHistoryController extends Controller
{
    public function store(Request $request)
    {
        // 1) Normalización de entradas (acepta “sí/si/1/true”, “no/0/false”, etc.)
        $data = $request->all();

        $yn = function ($v) {
            if ($v === null) return null;
            $v = strtolower((string)$v);
            return in_array($v, ['si','sí','1','true','t','y','yes'], true) ? 'si'
                 : (in_array($v, ['no','0','false','f','n'], true) ? 'no' : null);
        };

        $b = function ($v) {
            if ($v === null) return null;
            $v = strtolower((string)$v);
            return in_array($v, ['1','true','t','y','yes','si','sí'], true) ? 1 : 0;
        };

        foreach (['hipertension','diabetes','catarata'] as $f) {
            if (array_key_exists($f, $data)) $data[$f] = $yn($data[$f]);
        }

        foreach (['dolor_cabeza','dolor_ocular','cansancio_visual','hiperemia','epifora','secrecion'] as $f) {
            if (array_key_exists($f, $data)) $data[$f] = $b($data[$f]);
        }

        // Si no envían fecha, usamos ahora
        if (empty($data['date'])) {
            $data['date'] = now();
        }

        // 2) Validación
        $validated = validator($data, [
            'client_id'      => ['required','integer', Rule::exists('clients','id')],           // ajusta si tu tabla se llama distinto
            'id_oftalmologo' => ['required','integer', /* Rule::exists('users','id') */],       // ajusta si tienes tabla de oftalmólogos

            // 'date'   => ['nullable','date'],
            'reason' => ['required','string'],

            'hipertension'        => ['nullable'],
            'hipertension_estado' => ['nullable'],
            'diabetes'            => ['nullable'],
            'diabetes_estado'     => ['nullable'],
            'catarata'            => ['nullable'],

            'dolor_cabeza'     => ['nullable','boolean'],
            'dolor_ocular'     => ['nullable','boolean'],
            'cansancio_visual' => ['nullable','boolean'],
            'hiperemia'        => ['nullable','boolean'],
            'epifora'          => ['nullable','boolean'],
            'secrecion'        => ['nullable','boolean'],

            'cejas_od'            => ['nullable','string','max:50'],
            'cejas_oi'            => ['nullable','string','max:50'],
            'parpados_od'         => ['nullable','string','max:50'],
            'parpados_oi'         => ['nullable','string','max:50'],
            'pestanas_od'         => ['nullable','string','max:50'],
            'pestanas_oi'         => ['nullable','string','max:50'],
            'conjuntiva_od'       => ['nullable','string','max:50'],
            'conjuntiva_oi'       => ['nullable','string','max:50'],
            'aparato_lagrimal_od' => ['nullable','string','max:50'],
            'aparato_lagrimal_oi' => ['nullable','string','max:50'],
        ])->validate();

        // 3) Crear registro
        $mh = DB::transaction(function () use ($validated) {
            return MedicalHistory::create($validated);
        });

        return response()->json([
            'message' => 'Historia clínica registrada',
            'data'    => $mh,
        ], 201);
    }
}
