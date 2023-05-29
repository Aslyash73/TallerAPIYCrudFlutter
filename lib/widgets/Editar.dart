import 'package:aplicacion_asly/widgets/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplicacion_asly/widgets/Rutas.dart';

class Editar extends StatefulWidget {
  final Usuario usuario;
  const Editar({super.key, required this.usuario});

  @override
  State<Editar> createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  TextEditingController cNombre = TextEditingController();
  TextEditingController cApellidos = TextEditingController();
  TextEditingController cCorreo = TextEditingController();
  TextEditingController cGenero = TextEditingController();
  TextEditingController cTelefono = TextEditingController();

  @override
  void initState() {
    super.initState();
    cNombre.text = widget.usuario.nombre;
    cApellidos.text = widget.usuario.apellidos;
    cCorreo.text = widget.usuario.correo;
    cGenero.text = widget.usuario.genero;
    cTelefono.text = widget.usuario.telefono.toString();
  }

  Future<void> editarUsuario(context) async {
    final response = await http.post(Uri.parse(Rutas.dirServerEditar), body: {
      'id': widget.usuario.id,
      'nombres': cNombre.text,
      'apellidos': cApellidos.text,
      'correo': cCorreo.text,
      'genero': cGenero.text,
      'telefono': cTelefono.text,
    });
    print(response.statusCode);
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Usuarios"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: cNombre,
            decoration: const InputDecoration(labelText: "Nombre"),
          ),
          TextFormField(
            controller: cApellidos,
            decoration: const InputDecoration(labelText: "Apellidos"),
          ),
          TextFormField(
            controller: cCorreo,
            decoration: const InputDecoration(labelText: "Correo"),
          ),
          TextFormField(
            controller: cGenero,
            decoration: const InputDecoration(labelText: "Genero"),
          ),
          TextFormField(
            controller: cTelefono,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Telefono"),
          ),
          ElevatedButton(
              onPressed: () {
                editarUsuario(context);
              },
              child: const Text("Editar"))
        ],
      ),
    );
  }
}
