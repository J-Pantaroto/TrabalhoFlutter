import 'contato.dart';

class ListaContatos {
  List<Contato> contatos = [];

  void adicionarContato(Contato contato) {
    contatos.add(contato);
  }

  void editarContato(int index, Contato contato) {
    contatos[index] = contato;
  }

  void removerContato(int index) {
    contatos.removeAt(index);
  }

  List<Contato> getContatos() {
    return contatos;
  }
}
