import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detalle.dart';
import 'registrar.dart';
import 'Rutas.dart';
import 'usuario.dart';

class Inicio extends StatefulWidget {
  const Inicio({Key? key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  late Future<List<Usuario>> usuarios;

  @override
  void initState() {
    super.initState();
    usuarios = getUsuarios();
  }

  Future<List<Usuario>> getUsuarios() async {
    try {
      final url = Uri.parse(Rutas.dirServerListar);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return List<Usuario>.from(jsonData.map((x) => Usuario.fromJson(x)));
      } else {
        throw Exception('Failed to load usuarios');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de usuarios"),
      ),
      body: FutureBuilder<List<Usuario>>(
        future: usuarios,
        builder: (BuildContext context, AsyncSnapshot<List<Usuario>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay usuarios disponibles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var usuario = snapshot.data![index];
                return Card(
                  elevation: 2,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: const Icon(Icons.laptop),
                    trailing: const Icon(Icons.view_list),
                    title: Text(
                      usuario.nombre,
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detalle(usuario: usuario)),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.person),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Crear()),
          );
        },
      ),
    );
  }
}
