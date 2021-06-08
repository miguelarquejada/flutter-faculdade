 
import 'package:flutter/material.dart';

class StatusCompra extends StatelessWidget {

  MaterialColor color = Colors.green;
  String title = "";

  StatusCompra(String mensagem, MaterialColor cor) {
    title = mensagem;
    color = cor;
  }

   @override
   Widget build(BuildContext context) {
     return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: color)),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
              child: Text("voltar"),
              onPressed: () {
                Navigator.pop(context);
              }
            ),
          ]
        ) 
      )
     );
   }
 }