import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Ruta.dart';

class Crear extends StatefulWidget {
  const Crear({super.key});

  @override
  State<Crear> createState() => _CrearState();
}

class _CrearState extends State<Crear> {

  TextEditingController cNombre = TextEditingController();
  TextEditingController cPrecio = TextEditingController();

  Future crearProducto(context) async {
     await  http.post(Uri.parse("${Ruta.DIR_SERVER}/crear.php"),
      body:{
        'nombre': cNombre.text,
        'precio' : cPrecio.text
      }
    );
    Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Producto"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: cNombre,
            decoration: const InputDecoration(labelText: "Nombre"),
          ),

          TextFormField(
            controller: cPrecio,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Precio"),
          ),

          ElevatedButton(
            onPressed: (){
              crearProducto(context);
            },             
            child: const Text("Guardar"))
        ],
      ),
    );
  }
}