<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Symfony\Component\HttpFoundation\Response;
use Illuminate\Support\Facades\DB;

class UserController extends Controller
{

    public function todo(Request $request){
        $usuario = DB::select("SELECT * FROM ophthalmologists");
        return response()->json($usuario, 200);
    }
    public function registroOftalmologo(Request $request){

        $request->validate([
            'name'=>'required',
            'email'=>'email|required',
            'license_number'=>'required',
            'phone'=>'required',
            'password'=>'confirmed|required'
        ]);

        // $idRol= 7;

        $correo = $request->email;
        $usuarioEmail = DB::table('ophthalmologists')
                            ->where('email', $correo)
                            ->count();
        if($usuarioEmail == 1){
            return response()->json(['message' => 'Este correo esta registrado'], 233);
            
        }else{
            $usuario = new User;
            $usuario->name = $request->name;
            $usuario->email = $request->email;
            $usuario->phone = $request->phone;
            $usuario->license_number = $request->license_number;
            $usuario->password = sha1($request->contrasena);
            $result = $usuario->save();
            return response()->json(['message' => 'registro completado'], 200);
            
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


    public function tiempo(Request $request){
        $usuario = DB::select("SELECT * FROM tiempo");
        return response()->json($usuario, 200);
    }


}
