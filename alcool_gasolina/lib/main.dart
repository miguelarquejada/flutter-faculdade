import 'package:flutter/material.dart';

void main() async {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final valorGasolina = TextEditingController();
  final valorEtanol = TextEditingController();
  String resultado = "---";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo álcool x gasolina"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: valorEtanol,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor litro etanol R\$',
                  )),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                  controller: valorGasolina,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor litro gasolina R\$',
                  )),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                child: Text("Cotação"),
                color: Colors.orange,
                onPressed: () {
                  setState(() {
                    final double valor = double.parse(valorEtanol.text) / double.parse(valorGasolina.text);
                    if(valor < 0.7) {
                      resultado = "Etanol";
                    } else {
                      resultado = "Gasolina";
                    }
                  });
                },
                textColor: Colors.white,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text("Qual compensa mais? $resultado",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ],
          )
        ),
      ),
    );
  }
}
