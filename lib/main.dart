import 'package:flutter/material.dart';
import 'view/listar.dart';
import 'controller/contato_controller.dart';
import 'model/lista_contatos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ContatoController contatoController =
      ContatoController(ListaContatos());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda de Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Listar(controller: contatoController),
    );
  }
}
