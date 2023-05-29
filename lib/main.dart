import 'package:flutter/material.dart';
import 'widgets/Inicio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Usuarios APP',
      initialRoute: "/",
      routes: {
        "/": (context) => const Inicio(),
      },
    );
  }
}
