import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ExpansionTile(
        title: Text(
          'Cupom de desconto',
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.green[700]),
          textAlign: TextAlign.center,
        ),
        trailing: Icon(Icons.add),
        leading: Icon(Icons.card_giftcard),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu cupom'
              ),
              initialValue: CartModel.of(context).cuponCode ?? '',
              onFieldSubmitted: (text){
                Firestore.instance.collection('cupons').document(text).get().then((docSnap){
                  if (docSnap.data != null) {
                    CartModel.of(context).setCupon(text, docSnap.data['percetage']);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Desconto de ${docSnap.data['percetage']}% aplicado'),
                      backgroundColor: Theme.of(context).primaryColor,
                      )
                    );
                  } else {
                    CartModel.of(context).setCupon(null, 0);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Cupom não encontrado'),
                      backgroundColor: Colors.red,
                      )
                    );
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
