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
        $usuario = DB::select("SELECT * FROM clients");
        return response()->json($usuario, 200);
    }

    public function showClient($id)
{
    $o = Clients::find($id);
    if (!$o) return response()->json(['message' => 'No encontrado'], 404);
    return response()->json($o, 200);
}

}
