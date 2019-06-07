import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          'Calcular frete',
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.green[700]),
          textAlign: TextAlign.center,
        ),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu CEP'
              ),
              initialValue: '',
              onFieldSubmitted: (text){
                
              },
            ),
          )
        ],
      ),
    );
  }
}