<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{

    public function registroUser(Request $request){

        $request->validate([
            'nombre'=>'required',
            'telefono'=>'required',
            'correo'=>'email|required',
            'contrasena'=>'confirmed|required'
        ]);

        $idRol= 7;

        $correo = $request->correo;
        $usuarioEmail = DB::table('users')
                            ->where('correo', $correo)
                            ->count();
        if($usuarioEmail == 1){
            return response()->json(['message' => 'Este correo esta registrado'], 233);
            
        }else{
            $usuario = new User;
            $usuario->id_rol = $idRol;            
            $usuario->nombre = $request->nombre;
            $usuario->telefono = $request->telefono;
            $usuario->correo = $request->correo;
            $usuario->contrasena = sha1($request->contrasena);
            $result = $usuario->save();
            return $result;
        }

    }

    public function login(Request $request){
       
        $pass = sha1($request->contrasena);

        $usuario =  DB::select("SELECT id, nombre FROM users where nombre ='$request->nombre' OR telefono = '$request->nombre' OR correo = '$request->nombre'");
        
        if(count($usuario) > 0){
            $usuario2 = DB::select("SELECT id, nombre FROM users where nombre ='$request->nombre' OR telefono = '$request->nombre' OR correo = '$request->nombre'AND contrasena = '$pass'");
            if(count($usuario2) > 0){
                return response()->json($usuario2, 200);
            }else{
                return response()->json(['message' => 'contraseña incorrecta'], 222);
            }
        }else{
            return response()->json(['message' => 'No existe este usuario'], 208);
        }
    }

    public function sesion(Request $request){
        $request->validate([
            'id'=>'required',
        ]);

        $usuario= DB::select("SELECT nombre FROM users where id = '$request->id'");
        
        if(count($usuario) > 0){
            return response()->json($usuario, 200);
        }else{
            return response()->json(['message' => 'Sin autorizacion'], 400);
        }

        
        
    }


}
