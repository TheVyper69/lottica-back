<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\clients;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;   // 👈 IMPORTANTE
use Illuminate\Validation\Rule;             // (si usas reglas unique/ignore)
use Carbon\Carbon; 
use Illuminate\Support\Facades\Log;


class ClientsController extends Controller
{
    public function registroClients(Request $request)
{
    $request->validate([
        'first_name' =>'required',
        'last_name'  =>'required',
        'age'        =>'required|integer|min:0',
        'email'      =>'required|email',
        'phone'      =>'required',
        'address'    =>'required',
        'birthdate'  =>'required|date',
        'gender'     =>'required',
        'occupation' =>'required',
    ]);

    // ✅ Verificar si el correo ya existe (y no está soft-deleted)
    $exists = Clients::where('email', $request->email)
                     ->whereNull('deleted_at')
                     ->exists();

    if ($exists) {
        return response()->json([
            'message' => 'El correo ya está registrado'
        ], 409); // 409 Conflict
    }

    // Crear cliente si no existe
    $Client = Clients::create($request->all());

    return response()->json([
        'message' => 'Cliente registrado correctamente',
        'data'    => $Client
    ], 201);
}

    public function allClients(Request $request)
{
    $usuarios = DB::select("SELECT * FROM clients WHERE deleted_at IS NULL");
    return response()->json($usuarios, 200);
}


    public function showClient($id)
{
    // Solo clientes que NO están eliminados (deleted_at = null)
    $o = Clients::whereNull('deleted_at')->find($id);

    if (!$o) {
        return response()->json(['message' => 'No encontrado'], 404);
    }

    return response()->json($o, 200);
}

public function destroy($id)
{
    $client = Clients::find($id);

    if (!$client) {
        return response()->json(['message' => 'Cliente no encontrado'], 404);
    }

    // Si quieres borrado lógico con SoftDeletes:
    $client->delete();

    return response()->json(['message' => 'Cliente eliminado correctamente'], 200);
}

public function update(Request $request, $id)
{
    // 1) Encontrar cliente activo (no usar ->find() luego de whereNull)
    $client = Clients::where('id', $id)->whereNull('deleted_at')->first();
    if (!$client) {
        return response()->json(['message' => 'Cliente no encontrado'], 404);
    }

    // 2) Chequeo de correo duplicado (excluyendo este $id)
    if ($request->filled('email')) {
        $emailExists = Clients::where('email', $request->email)
            ->whereNull('deleted_at')
            ->where('id', '<>', $id)
            ->exists();

        if ($emailExists) {
            return response()->json(['message' => 'El correo ya está registrado'], 409);
        }
    }

    // 3) Validación flexible
    $validator = Validator::make($request->all(), [
        'first_name' => 'sometimes|required|string|max:100',
        'last_name'  => 'sometimes|required|string|max:100',
        'email'      => 'sometimes|nullable|email|max:255',
        'phone'      => 'sometimes|required|string|max:20',
        'address'    => 'sometimes|nullable|string',
        'birthdate'  => 'sometimes|required|date',
        'gender'     => 'sometimes|required|integer|in:1,2,3',
        'occupation' => 'sometimes|nullable|string|max:100',
        'age'        => 'sometimes|nullable|integer|min:0|max:130',
    ]);

    if ($validator->fails()) {
        return response()->json([
            'message' => 'Errores de validación',
            'errors'  => $validator->errors(),
        ], 422);
    }

    $data = $validator->validated();

    // 4) Normaliza strings (evita falsos "iguales" por espacios)
    foreach ($data as $k => $v) {
        if (is_string($v)) {
            $data[$k] = trim($v);
        }
    }

    // 5) Si viene birthdate y no age, calcúlalo
    if (!array_key_exists('age', $data) && array_key_exists('birthdate', $data) && $data['birthdate']) {
        $data['age'] = Carbon::parse($data['birthdate'])->age;
    }

    // ---- LOGS DE DIAGNÓSTICO ----
    Log::info('Update request all', $request->all());
    Log::info('Validated data', $data);
    Log::info('Before fill (original)', $client->toArray());

    // 6) Aplicar cambios y verificar qué cambió
    $client->fill($data);

    Log::info('Dirty attributes', $client->getDirty()); // <<--- clave para ver qué detecta como cambiado

    if (!$client->isDirty()) {
        return response()->json([
            'message' => 'No hay cambios para actualizar',
            'data'    => $client,
        ], 200);
    }

    $client->touch(); // solo actualiza updated_at
    $client->save();


    return response()->json([
        'message' => 'Cliente actualizado correctamente',
        'data'    => $client->fresh(),
    ], 200);
}

}
