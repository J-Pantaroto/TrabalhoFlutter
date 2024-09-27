import '../model/contato.dart';
import '../model/lista_contatos.dart';

class ContatoController {
  final ListaContatos _listaContatos;

  ContatoController(this._listaContatos) {
    _inicializarContatos();
  }

  void adicionarContato(Contato contato) {
    _listaContatos.adicionarContato(contato);
  }

  void editarContato(int index, Contato contato) {
    _listaContatos.editarContato(index, contato);
  }

  void removerContato(int index) {
    _listaContatos.removerContato(index);
  }

  List<Contato> getContatos() {
    return _listaContatos.getContatos();
  }

  void _inicializarContatos() {
    // Adiciona um contato padrão
    _listaContatos.adicionarContato(Contato(
      nome: "Jhonatan",
      telefone: "(67) 99622-8134",
      email: "jhonatanpantaroto@gmail.com",
    ));
  }
}
