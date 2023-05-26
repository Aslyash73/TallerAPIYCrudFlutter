import 'package:aplicacion_asly/widgets/producto.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_asly/widgets/Ruta.dart';
import 'package:aplicacion_asly/widgets/Editar.dart';
import 'package:http/http.dart' as http;

class Detalle extends StatefulWidget {
  final Producto producto;

  const Detalle({super.key, required this.producto});

  @override
  State<Detalle> createState() => _DetalleState();
}

class _DetalleState extends State<Detalle> {
  void eliminarProducto(context) async {
    await http.post(Uri.parse("${Ruta.DIR_SERVER}/eliminar.php"),
        body: {'id': widget.producto.id.toString()});
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  void confirmacion(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text("¿ Deseas eliminar este producto ?"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(Icons.cancel)),
              ElevatedButton(
                  onPressed: () {
                    eliminarProducto(context);
                  },
                  child: const Icon(Icons.check_circle)),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detalle producto"),
          actions: [
            IconButton(
                onPressed: () {
                  confirmacion(context);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Text("NOMBRE: ${widget.producto.nombre}"),
              Text("PRECIO: ${widget.producto.precio}"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return Editar(producto: widget.producto);
              }));
            }));
  }
}
