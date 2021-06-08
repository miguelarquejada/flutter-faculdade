
import 'package:onibus/entities/Passageiro.dart';

class Assento {
  
  int _numero;
  Passageiro _passageiro;

  Assento(int numero) {
    this._numero = numero;
  }

  bool assentoLivre() {
    return this._passageiro == null;
  }

  void reservarAssento(Passageiro passageiro) {
    this._passageiro = passageiro;
  }

  void cancelarReserva() {
    this._passageiro = null;
  }

  void setNumero(int numero) {
    this._numero = numero;
  }

  int getNumero() {
    return this._numero;
  }

  void setPassageiro(Passageiro passageiro) {
    this._passageiro = passageiro;
  }

  Passageiro getPassageiro() {
    return this._passageiro;
  }

}