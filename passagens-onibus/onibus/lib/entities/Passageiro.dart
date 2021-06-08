
import 'package:onibus/entities/Pessoa.dart';

class Passageiro extends Pessoa {

  int id;

  Passageiro(String nome, int idade, int cpf) : super(nome, idade, cpf);

  int getId() {
    return this.id;
  }

  void setId(int id) {
    this.id = id;
  }

}