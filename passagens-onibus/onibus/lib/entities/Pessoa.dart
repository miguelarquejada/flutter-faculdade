
abstract class Pessoa {

  String _nome;
  int _idade; 
  int _cpf;

  Pessoa(String nome, int idade, int cpf) {
    this._nome = nome;
    this._idade = idade;
    this._cpf = cpf;
  }

  String getNome() { 
    return this._nome;
  }

  void setNome(String nome) {
    this._nome = nome;
  }

  int getIdade() {
    return this._idade;
  }

  void setIdade(int idade) {
    this._idade = idade;
  }

  int getCpf() {
    return this._cpf;
  }

  void setcpf(int cpf) {
    this._cpf = cpf;
  }
}