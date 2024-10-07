import 'package:flutter/material.dart';
import 'view/listar.dart';
import 'controller/contato_controller.dart';
import 'database/contato_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final contatoDatabase = ContatoDatabase();
  final contatoController = ContatoController(contatoDatabase);

  runApp(MyApp(contatoController: contatoController));
}

class MyApp extends StatelessWidget {
  final ContatoController contatoController;

  MyApp({Key? key, required this.contatoController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda de Contatos',
      theme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: Listar(controller: contatoController),
    );
  }
}
