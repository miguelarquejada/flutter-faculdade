import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

void main() {
  runApp(MaterialApp(
      title: 'Cotação moeda',
      home: Home()
    )
  );
}

class Result extends StatelessWidget {
  final double resultado;

  Result(this.resultado);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Resultado'), 
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          tooltip: 'Navigation menu',
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ),
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'R\$ ${resultado}', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Dólar: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: '\$ 99.00', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Euro: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: '\€ 99.00', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(text: 'Libra: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  TextSpan(text: '\£ 99.00', style: TextStyle(fontSize: 20)),
                ]
              )
            )
          ]
        ),
      )
    );
  }
}

class Home extends StatelessWidget {
  var controller = MoneyMaskedTextController(leftSymbol: 'R\$ ', decimalSeparator: ',', thousandSeparator: '.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotação de moeda'), 
        centerTitle: true,
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.attach_money),
          tooltip: 'Navigation menu',
          onPressed: null,
        )
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'R\$ valor em reais',
              )
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text("Converter"),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Result(100.0)));
              }
            )
        ])
      )
    );
  }
}
