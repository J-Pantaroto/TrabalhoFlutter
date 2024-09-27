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
  bool _isHovered = false;
  bool _isFabHovered = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'Lista de Contatos',
            style: TextStyle(
              color: Colors.black, // Texto preto
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Listagem(controller: widget.controller),
      floatingActionButton: MouseRegion(
        onEnter: (_) => setState(() {
          _isFabHovered = true;
        }),
        onExit: (_) => setState(() {
          _isFabHovered = false;
        }),
        child: AnimatedScale(
          scale: _isFabHovered ? 1.2 : 1.0,
          duration: Duration(milliseconds: 200),
          child: FloatingActionButton(
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
            backgroundColor: Colors.white,
            child: Text(
              '+',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Listagem extends StatelessWidget {
  final ContatoController controller;

  Listagem({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final contatos = controller.getContatos();

    if (contatos.isEmpty) {
      return Center(child: Text('Nenhum contato cadastrado.'));
    }

    return ListView.builder(
      itemCount: contatos.length,
      itemBuilder: (context, index) {
        var contato = contatos[index];

        return HoverContainer(
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
              border: Border.all(
                color: Colors.transparent,
                width: 0,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contato.nome,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 4),
                Text(
                  contato.telefone,
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  contato.email,
                  style: TextStyle(color: Colors.white70),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HoverContainer extends StatefulWidget {
  final Widget child;

  HoverContainer({required this.child});

  @override
  _HoverContainerState createState() => _HoverContainerState();
}

class _HoverContainerState extends State<HoverContainer> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() {
        _isHovered = true;
      }),
      onExit: (_) => setState(() {
        _isHovered = false;
      }),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform:
            _isHovered ? Matrix4.identity().scaled(1.01) : Matrix4.identity(),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: const Color.fromARGB(255, 105, 107, 109)
                        .withOpacity(0.4),
                    spreadRadius: 3,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
