<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use App\Models\clients;
use Illuminate\Support\Facades\DB;



class ProductController extends Controller
{
    /**
     * GET /api/products
     * Lista (opcionalmente con búsqueda/paginación simple)
     */
    public function index(Request $request)
    {
        $q = Product::query(); // con SoftDeletes, por defecto excluye deleted_at

        // Filtros opcionales
        if ($search = $request->get('search')) {
            $q->where(function ($qq) use ($search) {
                $qq->where('name', 'like', "%{$search}%")
                  ->orWhere('category', 'like', "%{$search}%")
                  ->orWhere('brand', 'like', "%{$search}%")
                  ->orWhere('SN', 'like', "%{$search}%");
            });
        }
        if ($category = $request->get('category')) {
            $q->where('category', $category);
        }
        if ($brand = $request->get('brand')) {
            $q->where('brand', $brand);
        }

        // Paginación simple (opcional). Si no quieres paginar, usa ->get()
        $perPage = (int)($request->get('per_page', 15));
        $products = $q->orderByDesc('id')->paginate($perPage);

        return response()->json($products, 200);
    }

    /**
     * POST /api/products
     * Crear producto
     */
    public function store(Request $request)
{
    $data = $request->validate([
        'name'       => 'required|string|max:255',
        'category'   => 'nullable|string|max:100',
        'brand'      => 'nullable|string|max:100',
        'price'      => 'required|numeric|min:0',
        'stock'      => 'required|integer|min:0',
        'date_added' => 'nullable|date',
        'SN'         => 'required|string|max:100',
    ]);

    // 1) Buscar producto existente por SN (sin eliminados)
    $existing = Product::where('SN', $data['SN'])
        ->whereNull('deleted_at')
        ->first();

    if ($existing) {
        // 2) Si existe, solo actualizamos el stock sumando
        $existing->stock += $data['stock'];

        // (Opcional) también actualizar precio, nombre, etc.
        $existing->name     = $data['name'] ?? $existing->name;
        $existing->category = $data['category'] ?? $existing->category;
        $existing->brand    = $data['brand'] ?? $existing->brand;
        $existing->price    = $data['price'] ?? $existing->price;
        $existing->date_added = $data['date_added'] ?? $existing->date_added;

        $existing->save();

        return response()->json([
            'message' => 'Stock actualizado correctamente',
            'data'    => $existing,
        ], 200);
    }

    // 3) Si no existe, creamos nuevo
    $product = Product::create($data);

    return response()->json([
        'message' => 'Producto registrado correctamente',
        'data'    => $product,
    ], 201);
}


    /**
     * GET /api/products/{id}
     * Ver detalle (solo activos)
     */
    public function show($id)
    {
        $product = Product::where('id', $id)->first(); // SoftDeletes oculta los eliminados
        if (!$product) {
            return response()->json(['message' => 'Producto no encontrado'], 404);
        }
        return response()->json($product, 200);
    }

    /**
     * PUT/PATCH /api/products/{id}
     * Actualizar (validación flexible + SN único ignorando el propio)
     */
    public function update(Request $request, $id)
    {
        $product = Product::where('id', $id)->first();
        if (!$product) {
            return response()->json(['message' => 'Producto no encontrado'], 404);
        }

        $data = $request->validate([
            'name'       => 'sometimes|required|string|max:255',
            'category'   => 'sometimes|nullable|string|max:100',
            'brand'      => 'sometimes|nullable|string|max:100',
            'price'      => 'sometimes|required|numeric|min:0',
            'stock'      => 'sometimes|required|integer|min:0',
            'date_added' => 'sometimes|nullable|date',
            'SN'         => [
                'sometimes','nullable','string','max:100',
                Rule::unique('products','SN')->ignore($id)->whereNull('deleted_at'),
            ],
        ]);

        $product->fill($data);

        if (!$product->isDirty()) {
            return response()->json([
                'message' => 'No hay cambios para actualizar',
                'data'    => $product,
            ], 200);
        }

        $product->save();

        return response()->json([
            'message' => 'Producto actualizado correctamente',
            'data'    => $product->fresh(),
        ], 200);
    }

    /**
     * DELETE /api/products/{id}
     * Soft delete
     */
    public function destroy($id)
    {
        $product = Product::where('id', $id)->first();
        if (!$product) {
            return response()->json(['message' => 'Producto no encontrado'], 404);
        }

        $product->delete(); // SoftDeletes

        return response()->json(['message' => 'Producto eliminado'], 200);
    }
    

    /**
     * (Opcional) Restaurar un producto soft-deleted
     * POST /api/products/{id}/restore
     */
    public function restore($id)
    {
        $product = Product::onlyTrashed()->where('id', $id)->first();
        if (!$product) {
            return response()->json(['message' => 'Producto no encontrado o no está eliminado'], 404);
        }
        $product->restore();
        return response()->json(['message' => 'Producto restaurado', 'data' => $product], 200);
    }

    /**
     * (Opcional) Borrado permanente
     * DELETE /api/products/{id}/force
     */
    public function forceDelete($id)
    {
        $product = Product::onlyTrashed()->where('id', $id)->first();
        if (!$product) {
            return response()->json(['message' => 'Producto no encontrado o no está eliminado'], 404);
        }
        $product->forceDelete();
        return response()->json(['message' => 'Producto eliminado definitivamente'], 200);
    }

    public function showBrand(Request $request){
        $usuarios = DB::select("SELECT * FROM brand");
        return response()->json($usuarios, 200);
    }
    public function showCategoria(Request $request){
        $usuarios = DB::select("SELECT * FROM categoria");
        return response()->json($usuarios, 200);
    }

    public function allProducts(Request $request)
    {
        $usuarios = DB::select("SELECT p.id, p.name, c.name AS category_name, b.name AS brand_name, p.price, p.stock, p.date_added, p.SN, p.created_at, p.updated_at FROM products AS p LEFT JOIN categoria AS c ON c.id = p.category LEFT JOIN brand AS b ON b.id = p.brand WHERE p.deleted_at IS NULL;");
        return response()->json($usuarios, 200);
    }
    public function showProduct($id)
        {
            // Solo clientes que NO están eliminados (deleted_at = null)
            $o = Product::whereNull('deleted_at')->find($id);

            if (!$o) {
                return response()->json(['message' => 'No encontrado'], 404);
            }

            return response()->json($o, 200);
        }

    
}
