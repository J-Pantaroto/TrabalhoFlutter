import 'package:flutter/material.dart';
import '../controller/contato_controller.dart';
import 'cadastro.dart';

class Listar extends StatefulWidget {
  final ContatoController controller;

  Listar({Key? key, required this.controller}) : super(key: key);

  @override
  _ListarState createState() => _ListarState();
}

class _ListarState extends State<Listar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Contatos'),
      ),
      body: Listagem(controller: widget.controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cadastro(
                controller: widget.controller,
              ),
            ),
          );

          if (result == true) {
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Listagem extends StatefulWidget {
  final ContatoController controller;

  Listagem({Key? key, required this.controller}) : super(key: key);

  @override
  _ListagemState createState() => _ListagemState();
}

class _ListagemState extends State<Listagem> {
  @override
  Widget build(BuildContext context) {
    final contatos = widget.controller.getContatos();

    if (contatos.isEmpty) {
      return Center(child: Text('Nenhum contato cadastrado.'));
    }

    return ListView.builder(
      itemCount: contatos.length,
      itemBuilder: (context, index) {
        var contato = contatos[index];

        return ListTile(
          title: Text(contato.nome),
          subtitle:
              Text('Telefone: ${contato.telefone} - Email:${contato.email}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Cadastro(
                        controller: widget.controller,
                        index: index,
                      ),
                    ),
                  );
                  if (result == true) {
                    setState(() {}); // Atualiza a lista após edição
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Remover Contato'),
                      content:
                          Text('Tem certeza que deseja remover este contato?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancelar'),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              widget.controller.removerContato(index);
                            });
                            Navigator.pop(context); // Fecha o diálogo
                          },
                          child: Text('Remover',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
