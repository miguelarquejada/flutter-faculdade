import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Cálculo de salário',
    home: Home()
  ));
}

// tela 1
class Home extends StatefulWidget {
  @override
  _Home createState() {
    return _Home();
  }
} 

class _Home extends State<Home> {

  TextEditingController horasTrabalhadas = TextEditingController();
  TextEditingController salarioHora = TextEditingController();
  TextEditingController numeroDependentes = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cálculo de salário")
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 40.0, right: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: horasTrabalhadas,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Horas trabalhadas"
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: salarioHora,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Salário hora"
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: numeroDependentes,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Número de dependentes"
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              child: Text("Calcular"),
              onPressed: () {
                _sendData(context);
              },
            )
          ],
        )
      )
    );
  }
  
  void _sendData(BuildContext context) {
    double hTrabalhadas = double.parse(horasTrabalhadas.text);
    double sHora = double.parse(salarioHora.text);
    double nDependentes = double.parse(numeroDependentes.text);

    double salarioBruto = hTrabalhadas * sHora + (50 * nDependentes);
    double descontoInss;
    if(salarioBruto <= 1000) {
      descontoInss = salarioBruto * 8.5/100;
    } else {
      descontoInss = salarioBruto * 9/100;
    }
    double descontoIr;
    if(salarioBruto <= 500) {
      descontoIr = 0;
    } else if(salarioBruto > 500 && salarioBruto <= 1000) {
      descontoIr = salarioBruto * 5/100;
    } else {
      descontoIr = salarioBruto * 7/100;
    }
    double salarioLiquido = salarioBruto - descontoInss - descontoIr;

    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => Result(salarioBruto, descontoInss, descontoIr, salarioLiquido)
      ));
  }
}

// tela 2
class Result extends StatelessWidget {
  double salarioBruto;
  double descontoInss;
  double descontoIr;
  double salarioLiquido;

  Result(
    this.salarioBruto, 
    this.descontoInss, 
    this.descontoIr,
    this.salarioLiquido
  );

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Salário bruto: R\$ ${salarioBruto}"),
            Text("Desconto INSS: R\$ ${descontoInss}"),
            Text("Desconto IR: R\$ ${descontoIr}"),
            Text("Salário líquido: R\$ ${salarioLiquido}"),
          ],
        ),
      )
    );
  }
}
