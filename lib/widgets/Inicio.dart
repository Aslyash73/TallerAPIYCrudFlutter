import 'dart:convert';

import 'package:flutter/material.dart';
import 'Ruta.dart';
import 'package:http/http.dart' as http;
import 'producto.dart';
import 'detalle.dart';
import 'crear.dart';

class Inicio extends StatefulWidget {
  const Inicio({super.key});

  @override
  State<Inicio> createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  
  late Future<List<Producto>> productos;

  @override
  void initState(){
    super.initState();  
    productos = getProductos();
  }

  Future<List<Producto>> getProductos() async{
     final respuesta =  await http.get(Uri.parse("${Ruta.DIR_SERVER}/listar.php"));
     final items  = json.decode(respuesta.body).cast<Map<String,dynamic>>();
     List<Producto> pr = items.map<Producto>((json){
        return Producto.fromJson(json);
     }).toList();
     return pr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listado de productos"),
        
      ),
      body: FutureBuilder<List<Producto>>(
          future: productos,
          builder: (BuildContext context , AsyncSnapshot snapshot){
            if(!snapshot.hasData) return const CircularProgressIndicator();

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context , int index){
                var dato = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.laptop),
                    trailing: const Icon(Icons.view_list),
                    title: Text(
                      dato.nombre,
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => Detalle(producto: dato)));
                    },
                  ),
                );
              },
            );
          },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_){
             return Crear();
          }
          ));
        }
      )
    );
  }
}