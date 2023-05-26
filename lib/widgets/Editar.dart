import 'package:aplicacion_asly/widgets/producto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Ruta.dart';

class Editar extends StatefulWidget {
  final Producto producto;
  const Editar({super.key, required this.producto});

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  TextEditingController cNombre = TextEditingController();
  TextEditingController cPrecio = TextEditingController();

  @override
  void initState() {
    super.initState();
    cNombre.text = widget.producto.nombre;
    cPrecio.text = widget.producto.precio.toString();
  }

  Future<void> EditarProducto(context) async {
    await http.post(Uri.parse("${Ruta.DIR_SERVER}/editar.php"), body: {
      'id': widget.producto.id.toString(),
      'nombre': cNombre.text,
      'precio': cPrecio.text
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Producto"),
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
              onPressed: () {
                EditarProducto(context);
              },
              child: const Text("Editar"))
        ],
      ),
    );
  }
}
