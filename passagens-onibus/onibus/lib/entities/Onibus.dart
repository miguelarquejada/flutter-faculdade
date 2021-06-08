
import 'package:onibus/entities/Assento.dart';

class Onibus {
  
  List<Assento> _assentos = <Assento>[];

  Onibus() {
    for(int i = 1; i <= 40; i++) {
      Assento novoAssento = new Assento(i);
      this._assentos.add(novoAssento);
    }
  }

  List<Assento> getAssentos() {
    return this._assentos;
  }

  Assento getAssento(int index) {
    return this._assentos.elementAt(index);
  }

  void setAssentos(List<Assento> assentos) {
    this._assentos = assentos;
  }

}