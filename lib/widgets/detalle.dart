import 'package:aplicacion_asly/widgets/usuario.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_asly/widgets/Rutas.dart';
import 'package:aplicacion_asly/widgets/Editar.dart';
import 'package:http/http.dart' as http;

class Detalle extends StatefulWidget {
  final Usuario usuario;

  const Detalle({Key? key, required this.usuario}) : super(key: key);

  @override
  State<Detalle> createState() => _DetalleState();
}

class _DetalleState extends State<Detalle> {
  void eliminarUsuario(context) async {
    await http
        .post(Uri.parse("${Rutas.dirServerEliminar}&id=${widget.usuario.id}"));
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  void confirmacion(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text("¿Deseas eliminar este registro?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.cancel),
            ),
            ElevatedButton(
              onPressed: () {
                eliminarUsuario(context);
              },
              child: const Icon(Icons.check_circle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Informacion de Usuario"),
        actions: [
          IconButton(
            onPressed: () {
              confirmacion(context);
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: SizedBox(
          height: 300, // Altura deseada de la Card
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "NOMBRE: ${widget.usuario.nombres}",
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "APELLIDOS: ${widget.usuario.apellidos}",
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "CORREO: ${widget.usuario.correo}",
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "GENERO: ${widget.usuario.genero}",
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "TELEFONO: ${widget.usuario.telefono}",
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return Editar(usuario: widget.usuario);
          }));
        },
      ),
    );
  }
}
