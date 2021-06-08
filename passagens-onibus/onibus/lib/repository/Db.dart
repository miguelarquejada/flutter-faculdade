import 'package:onibus/entities/Assento.dart';
import 'package:onibus/entities/Onibus.dart';
import 'package:onibus/entities/Passageiro.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final Db _singleton = new Db();

  factory Db() {
    return _singleton;
  }

  static _dataBaseManager() async {
    final int versiondb = 1;
    final pathDatabase = await getDatabasesPath();
    final localDatabase = join(pathDatabase, "busdev.db");

    var bd = await openDatabase(localDatabase, version: versiondb,
        onCreate: (db, versiondb) {
          String sql = "create table passagens(id integer primary key, numero integer, nome_passageiro varchar, idade_passageiro integer, cpf_passageiro integer)"; 
          db.execute(sql);
    });
    return bd;
  }


  static salvarAssentos(List assentos) async {
    Database bd = await _dataBaseManager();

    await bd.rawDelete("delete from passagens");

    for (Assento assento in assentos) {
      Map<String, dynamic> data = {"numero": assento.getNumero(), "nome_passageiro": assento.getPassageiro().getNome(), "idade_passageiro": assento.getPassageiro().getIdade(), "cpf_passageiro": assento.getPassageiro().getCpf()};
      await bd.insert("passagens", data);
    }
  }

  static buscarAssentos(Onibus onibus) async {
    Database bd = await _dataBaseManager();
    List listaPassagens = await bd.rawQuery("select * from passagens");
    List<Assento> assentos = <Assento>[];
    
    for (var passagem in listaPassagens) {
      String nomePassageiro = passagem['nome_passageiro'];
      int idadePassageiro = int.parse(passagem['idade_passageiro']);
      int cpfPassageiro = int.parse(passagem['idade_passageiro']);

      Passageiro passageiro = new Passageiro(nomePassageiro, idadePassageiro, cpfPassageiro);
      Assento assento = new Assento(int.parse(passagem["numero"]));
      assento.setPassageiro(passageiro);

      assentos.add(assento);
    }

    onibus.setAssentos(assentos);
  }
  
}