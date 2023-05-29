import 'package:aplicacion_asly/widgets/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplicacion_asly/widgets/Rutas.dart';

class Editar extends StatefulWidget {
  final Usuario usuario;
  const Editar({Key? key, required this.usuario}) : super(key: key);

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
    cNombre.text = widget.usuario.nombres;
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 5,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: cNombre,
                    decoration: const InputDecoration(labelText: "Nombre"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cApellidos,
                    decoration: const InputDecoration(labelText: "Apellidos"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cCorreo,
                    decoration: const InputDecoration(labelText: "Correo"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cGenero,
                    decoration: const InputDecoration(labelText: "Genero"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: cTelefono,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Telefono"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este dato es requerido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        editarUsuario(context);
                      },
                      child: const Text("Guardar"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
