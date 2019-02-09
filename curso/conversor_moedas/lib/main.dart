import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

const request = "https://api.hgbrasil.com/finance?format=jason&key=60df7606";

void main() async {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(hintColor: Colors.amber, primaryColor: Colors.white),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final realCtrl = TextEditingController();
  final dolarCtrl = TextEditingController();
  final euroCtrl = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String text) {
    double real  = double.parse(text);
    dolarCtrl.text = (real/dolar).toStringAsFixed(2);
    euroCtrl.text = (real/euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    double dolar = double.parse(text);
    realCtrl.text = (dolar*this.dolar).toStringAsFixed(2);
    euroCtrl.text = (dolar*this.dolar/euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    realCtrl.text = (euro*this.euro).toStringAsFixed(2);
    dolarCtrl.text = (euro*this.euro/dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Text(
          '\$ Conversor de moedas \$',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando dados...",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar dados...",
                    style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  ),
                );
              } else {
                dolar = snapshot.data['results']['currencies']['USD']['buy'];
                euro = snapshot.data['results']['currencies']['EUR']['buy'];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(
                        Icons.monetization_on,
                        size: 150.0,
                        color: Colors.amber,
                      ),
                      Divider(),
                      buildTextField('Reais', "R\$ ", realCtrl, _realChanged),
                      Divider(),
                      buildTextField('Dólares', "US\$ ", dolarCtrl, _dolarChanged),
                      Divider(),
                      buildTextField('Euros', "€ ", euroCtrl, _euroChanged)
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

Widget buildTextField(String moeda, String prefix, TextEditingController ctrl, Function f) {
  return TextField(
    controller: ctrl,
    decoration: InputDecoration(
        labelText: moeda,
        labelStyle: TextStyle(color: Colors.amber, fontSize: 25.0),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.amber, fontSize: 25.0),
    onChanged: f,
    keyboardType: TextInputType.number,
  );
}
