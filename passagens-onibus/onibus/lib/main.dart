import 'package:flutter/material.dart';
import 'package:onibus/entities/Assento.dart';
import 'package:onibus/entities/Onibus.dart';
import 'package:onibus/screens/comprar.dart';
import 'package:onibus/screens/relatorio.dart';
import 'package:onibus/screens/statusCompra.dart';

/*
  NOTA: VERSÃO OFFLINE
  -> necessário arrumar erro da versão online
*/

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Comprar(),
    );
  }
}
