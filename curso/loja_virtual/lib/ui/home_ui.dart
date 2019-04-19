import 'package:flutter/material.dart';
import 'package:loja_virtual/tab/home_tab.dart';

class HomeScreen extends StatelessWidget {

  final _pageCtrl = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageCtrl,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        HomeTab(),
      ],
    );
  }
}