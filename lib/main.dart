import 'package:flutter/material.dart';
import 'widgets/Inicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Usuarios APP',
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(
            255, 184, 204, 228), // Cambia el color de fondo a rosado
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const Inicio(),
      },
    );
  }
}
