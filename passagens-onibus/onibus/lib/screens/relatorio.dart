import 'package:flutter/material.dart';
import 'package:onibus/entities/Assento.dart';
import 'package:onibus/entities/Onibus.dart';
import 'package:onibus/entities/Passageiro.dart';

class Relatorio extends StatelessWidget {
  List<Assento> _assentos;

  Relatorio(Onibus onibus) {
    this._assentos = onibus.getAssentos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de tarefas")),
      body: ListView.builder(
        itemCount: this._assentos.length,
        itemBuilder: (context, index) {
          Assento assentoAtual = this._assentos.elementAt(index);
          String numeroAssento = assentoAtual.getNumero().toString();
          String mensagem = "--livre--";

          String nomePassageiro = "";
          String idadePassageiro = "";
          String cpfPassageiro = "";

          if(assentoAtual.getPassageiro() != null) {
            Passageiro passageiro = assentoAtual.getPassageiro();
            nomePassageiro = passageiro.getNome();
            idadePassageiro = passageiro.getIdade().toString();
            cpfPassageiro = passageiro.getCpf().toString();

            mensagem = "passageiro: " + nomePassageiro + "\n" +
                       "idade: " + idadePassageiro + " anos \n" +
                       "cpf: " + cpfPassageiro;
          }

          return ListTile(
            title: GestureDetector(
              onTap: () => {},
              onLongPress: () => {},
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(children: [
                    Text('poltrona ' + numeroAssento, style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(mensagem, textAlign: TextAlign.center)
                  ]),
                ),
              ))
            );
        }
      )
    );
  }
}
