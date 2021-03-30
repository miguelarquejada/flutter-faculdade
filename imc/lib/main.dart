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
  final altura = TextEditingController();
  final peso = TextEditingController();
  String resultado = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo de IMC"),
        backgroundColor: Colors.deepOrange,
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                  controller: altura,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Altura (m)',
                  )),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                  controller: peso,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Peso (Kg)',
                  )),
              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                child: Text("Cotação"),
                color: Colors.deepOrange,
                onPressed: () {
                  setState(() {
                    final double valor = double.parse(peso.text) /  (double.parse(altura.text) * double.parse(altura.text));
                    if(valor <= 18.5) {
                      resultado = "Magreza";
                    } else if(valor > 18.5 && valor <= 24.9) {
                      resultado = "Normal";
                    } else if(valor > 24.9 && valor <= 29.9) {
                      resultado = "Sobrepeso";
                    } else if(valor > 29.9 && valor <= 39.9) {
                      resultado = "Obesidade";
                    } else if(valor > 39.9) {
                      resultado = "Obesidade grave";
                    }
                  });
                },
                textColor: Colors.white,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text("$resultado",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
            ],
          )
        ),
      ),
    );
  }
}
