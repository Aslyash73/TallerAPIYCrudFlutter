class Producto{
 final int id;
 final String nombre;
 final int precio;
 
 Producto({required this.id, required this.nombre, required this.precio});

 factory Producto.fromJson(Map<String, dynamic> json){
   return Producto(
      id:     int.parse(json["PRO_ID"]), 
      nombre: json["PRO_NOMBRE"], 
      precio: int.parse(json["PRO_PRECIO"])
    );
 }

 Map<String, dynamic> toJson() => {
    "nombre": nombre,
    "precio": precio
 };
}