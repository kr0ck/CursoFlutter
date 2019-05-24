import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_model.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:loja_virtual/ui/home_ui.dart';
import 'package:scoped_model/scoped_model.dart';
//import 'package:loja_virtual/ui/login_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModel<CartModel>(
          model: CartModel(),
          child: MaterialApp(
            title: 'Flutter`s Clothing',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Color.fromARGB(255, 4, 125, 141)),
            debugShowCheckedModeBanner: false,
            home: HomeScreen(), //HomeScreen(),
          ),
        ));
  }
}
