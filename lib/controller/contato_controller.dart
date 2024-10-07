import '../database/contato_database.dart';
import '../model/contato.dart';

class ContatoController {
  final ContatoDatabase _contatoDatabase;

  ContatoController(this._contatoDatabase);

  Future<List<Contato>> getContatos() async {
    return await _contatoDatabase.getContatos();
  }

  Future<void> adicionarContato(Contato contato) async {
    await _contatoDatabase.adicionarContato(contato);
  }

  Future<void> editarContato(Contato contato) async {
    if (contato.id != null) {
      await _contatoDatabase.editarContato(contato);
    }
  }

  Future<void> removerContato(int id) async {
    await _contatoDatabase.removerContato(id);
  }
}
