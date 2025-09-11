<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\clients;
use Illuminate\Support\Facades\DB;


class ClientsController extends Controller
{
    public function registroClients(Request $request)
    {
        $request->validate([
            'first_name' =>'required',
            'last_name'=>'required',
            'age'=>'required',
            'email'=>'required|email',
            'phone'=>'required',
            'address'=>'required',
            'birthdate'=>'required',
            'gender'=>'required',
            'occupation'=>'required',
        ]);

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

}
