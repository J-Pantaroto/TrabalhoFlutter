import '../model/contato.dart';
import '../model/lista_contatos.dart';

class ContatoController {
  final ListaContatos _listaContatos;

  ContatoController(this._listaContatos);

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
}
