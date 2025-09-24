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
            'phone'=>'required',
            'license_number'=>'required',
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
            // $usuario = new User;
            // $usuario->name = $request->name;
            // $usuario->email = $request->email;
            // $usuario->phone = $request->phone;
            // $usuario->license_number = $request->license_number;
            // $usuario->password = sha1($request->password);
            // $result = $usuario->save();
            $pass = sha1($request->password);
            $usuario2 = DB::select("INSERT INTO ophthalmologists (name, email, phone, license_number, password) VALUES 
            ('$request->name', '$request->email', '$request->phone', '$request->license_number', '$pass')");
            return response()->json(['message' => 'registro completado'], 200);
            
        }

    }

    public function login(Request $request){
       
        
        $request->validate([
            'name'=>'required',
            'contrasena'=>'required'
        ]);
        $pass = sha1($request->contrasena);
                    

        $usuario =  DB::select("SELECT id, name FROM ophthalmologists where name ='$request->name' OR phone = '$request->name' OR email = '$request->name'");
        
        if(count($usuario) > 0){
            $usuario2 = DB::select("SELECT id, name FROM ophthalmologists where name ='$request->name' OR phone = '$request->name' OR email = '$request->name'AND password = '$pass'");
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
