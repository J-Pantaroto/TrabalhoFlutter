import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../controller/contato_controller.dart';
import '../model/contato.dart';

class Cadastro extends StatefulWidget {
  final ContatoController controller;
  final int? index;

  Cadastro({Key? key, required this.controller, this.index}) : super(key: key);

  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final _nomeController = TextEditingController();
  final _telefoneController = MaskedTextController(mask: '(00) 00000-0000');
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      // Chamar do bd
      _carregarContato(widget.index!);
    }
  }

  Future<void> _carregarContato(int index) async {
    List<Contato> contatos = await widget.controller.getContatos();
    var contato = contatos[index];

    setState(() {
      _nomeController.text = contato.nome;
      _telefoneController.text = contato.telefone;
      _emailController.text = contato.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index == null ? 'Novo Contato' : 'Editar Contato'),
        actions: [
          if (widget.index != null)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                await widget.controller.removerContato(widget.index!);
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O nome é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O telefone é obrigatório';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'O e-mail é obrigatório';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.index == null) {
                      await widget.controller.adicionarContato(
                        Contato(
                          nome: _nomeController.text,
                          telefone: _telefoneController.text,
                          email: _emailController.text,
                        ),
                      );
                    } else {
                      await widget.controller.editarContato(
                        Contato(
                          id: widget.index,
                          nome: _nomeController.text,
                          telefone: _telefoneController.text,
                          email: _emailController.text,
                        ),
                      );
                    }
                    Navigator.pop(context, true);
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
