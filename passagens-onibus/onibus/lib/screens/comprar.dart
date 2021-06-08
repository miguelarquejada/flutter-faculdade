import 'package:flutter/material.dart';
import 'package:onibus/entities/Assento.dart';
import 'package:onibus/entities/Onibus.dart';
import 'package:onibus/entities/Passageiro.dart';
import 'package:onibus/screens/relatorio.dart';
import 'package:onibus/repository/Db.dart';
import 'package:onibus/screens/statusCompra.dart';

class Comprar extends StatefulWidget {
  @override
  _ComprarState createState() => _ComprarState();
}

class _ComprarState extends State<Comprar> {
  double _precoPassagem = 10.00;
  int _poltronasCompradas = 0;
  int _totalPoltronas = 40;
  Onibus onibus = new Onibus();

  final TextEditingController _nomePassageiro = TextEditingController();
  final TextEditingController _idadePassageiro = TextEditingController();
  final TextEditingController _cpfPassageiro = TextEditingController();
  final TextEditingController _numAssento = TextEditingController();

  void resetarValoresInputs() {
    _nomePassageiro.text = "";
    _idadePassageiro.text = "";
    _cpfPassageiro.text = "";
    _numAssento.text = "";
  }

  void navegarParaTelaStatusCompra(String mensagem, MaterialColor corMensagem) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => StatusCompra(mensagem, corMensagem)));
  }

  void checarQuantidadePoltronasCompradas() {
    if(_poltronasCompradas >= 28) {
      setState(() {
        _precoPassagem = 15.00;
      });
    }
  }

  bool checarAssentoDisponivel(Assento assento) {
    if(assento.getPassageiro() != null) {
      navegarParaTelaStatusCompra("Assento indisponível.", Colors.red);
      return false;
    }
    return true;
  }

  bool checarAlgumCampoVazio() {
    if(_nomePassageiro.text == "" || _idadePassageiro.text == "" || _cpfPassageiro.text == "" || _numAssento.text == "") {
      navegarParaTelaStatusCompra("Dados inválidos.", Colors.red);
      return false;
    }

    return true;
  }

  bool checarNumeroDePoltronaValido() {
    if(int.parse(_numAssento.text) < 0 || int.parse(_numAssento.text) > _totalPoltronas) {
      navegarParaTelaStatusCompra("Número de poltrona inválido.", Colors.red);
      return false;
    }
    return true;
  }

  bool checarCompradorMaiorDeIdade() {
    if(int.parse(_idadePassageiro.text) < 18) {
      navegarParaTelaStatusCompra("Menores de idade não podem efetuar compras.", Colors.red);
      return false;
    }
    return true;
  }

  bool checarExistePoltronaDisponivel() {
    if(_poltronasCompradas == 40) {
      navegarParaTelaStatusCompra("Nenhuma poltrona disponível para compra.", Colors.red);
      return false;
    }
    return true;
  }

  int buscarQuantidadeDePassagensCompradas() {
    int qtdAssentosJaComprados = 0;
    for (int i = 0; i < onibus.getAssentos().length; i++) {
      Passageiro passageiro = onibus.getAssento(i).getPassageiro();
      if(passageiro != null && passageiro.getCpf() == int.parse(_cpfPassageiro.text)) qtdAssentosJaComprados++;
    }

    return qtdAssentosJaComprados;
  }

  bool checarLimiteDeCompraNaoAtingido() {
    if(buscarQuantidadeDePassagensCompradas() == 2) {
      navegarParaTelaStatusCompra("Limite de compra atingido.", Colors.red);
      return false;
    }
    return true;
  }

  bool comprarPassagem() {
    if( !checarAlgumCampoVazio() ||
        !checarNumeroDePoltronaValido() ||
        !checarCompradorMaiorDeIdade() ||
        !checarExistePoltronaDisponivel() ||
        !checarLimiteDeCompraNaoAtingido() ) return false;


    bool sucessoNaCompra = false;
    // busca o assento de acordo com o número digitado e faz a compra setando o passageiro
    for (int i = 0; i < onibus.getAssentos().length; i++) {
      Assento assento = onibus.getAssento(i);

      String nomeDigitadoPassageiro = _nomePassageiro.text;
      int idadeDigitadoPassageiro = int.parse(_idadePassageiro.text);
      int cpfDigitadoPassageiro = int.parse(_cpfPassageiro.text);
      int numeroDigitadoAssento = int.parse(_numAssento.text);

      if(assento.getNumero() == numeroDigitadoAssento) {
        if(!checarAssentoDisponivel(assento)) break;

        setState(() { _poltronasCompradas++; });
        assento.setPassageiro(new Passageiro(nomeDigitadoPassageiro, idadeDigitadoPassageiro, cpfDigitadoPassageiro));
        
        sucessoNaCompra = true;
        break;
      }
    }

    if(!sucessoNaCompra) return false;

    checarQuantidadePoltronasCompradas();
    resetarValoresInputs();
    navegarParaTelaStatusCompra("Compra efetuada \n com sucesso.", Colors.green);
    
    // Db.salvarAssentos(onibus.getAssentos());
    // Db.buscarAssentos(onibus);
    
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comprar passagem"),
      ),
      body: Container (
        margin: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Valor atual por passagem:'),
                Text('R\$ ' + _precoPassagem.toString(), 
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                SizedBox(
                  height: 40.0,
                ),
                Text(_poltronasCompradas.toString() + " / " + _totalPoltronas.toString() + " poltronas disponíveis"),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _nomePassageiro,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nome',
                  )
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _idadePassageiro,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Idade',
                  )
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _cpfPassageiro,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cpf'
                  )
                ),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: _numAssento,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'nº assento'
                  )
                ),
                SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                  child: Text("Comprar"),
                  onPressed: () {
                    comprarPassagem();
                  }
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  child: Text("gerar relatório"),
                  style: ElevatedButton.styleFrom(primary: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Relatorio(onibus)));
                  }
                ),
              ],
            ),
          )
        ) 
        
      )
    );
  }
}