import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplicacion_asly/widgets/Rutas.dart';

class Crear extends StatefulWidget {
  const Crear({Key? key});

  @override
  State<Crear> createState() => _CrearState();
}

class _CrearState extends State<Crear> {
  TextEditingController cNombre = TextEditingController();
  TextEditingController cApellidos = TextEditingController();
  TextEditingController cCorreo = TextEditingController();
  String cGenero = "Femenino"; // Valor predeterminado para el género
  TextEditingController cTelefono = TextEditingController();

  bool mostrarPassword = false;

  Future<void> crearUsuario(context) async {
    await http.post(Uri.parse(Rutas.dirServerRegistrar), body: {
      'nombres': cNombre.text,
      'apellidos': cApellidos.text,
      'correo': cCorreo.text,
      'genero': cGenero,
      'telefono': cTelefono.text,
    });
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrar Usuario"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  DropdownButtonFormField<String>(
                    value: cGenero,
                    onChanged: (String? newValue) {
                      setState(() {
                        cGenero = newValue!;
                      });
                    },
                    decoration: const InputDecoration(labelText: "Género"),
                    items: <String>['Femenino', 'Masculino', 'Otro']
                        .map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                  ),
                  TextFormField(
                    controller: cTelefono,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Teléfono"),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      crearUsuario(context);
                    },
                    child: const Text("Guardar"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
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
