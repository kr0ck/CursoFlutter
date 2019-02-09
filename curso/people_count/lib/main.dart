import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: "Contador de Pessoas",
      home: CountPeople(),
    ),
  );
}

class CountPeople extends StatefulWidget {
  @override
  _CountPeopleState createState() => _CountPeopleState();
}

class _CountPeopleState extends State<CountPeople> {

  int _people = 0;
  String _infoText = "Pode entrar!!!";

  void _changePeople(int delta){
    setState(() {
      _people+=delta;  
      if (_people<0){
        _infoText = "Mundo invertido!!!";
      }else if(_people>10){
        _infoText = "Restaurante Cheio!!!";
      }else{
        _infoText = "Pode Entrar!!!";
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/restaurante.jpg",
          fit: BoxFit.cover,
          height: 1000.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pessoas: $_people",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "+1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {
                      _changePeople(1);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    child: Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {
                      _changePeople(-1);
                    },
                  ),
                ),
              ],
            ),
            Text(
              _infoText,
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0),
            ),
          ],
        ),
      ],
    );
  }
}
