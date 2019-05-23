import 'package:flutter/material.dart';
import 'package:loja_virtual/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SingUpScreen extends StatefulWidget {
  @override
  _SingUpScreenState createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  final _nameCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Criar conta'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: _nameCtrl,
                decoration: InputDecoration(hintText: 'Nome Completo'),
                validator: (text) {
                  if (text.isEmpty || text.length < 3) {
                    return 'Nome inválido!!!';
                  }
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _addressCtrl,
                decoration: InputDecoration(hintText: 'Endereço'),
                validator: (text) {
                  if (text.isEmpty || text.length < 3) {
                    return 'Endereço inválido!!!';
                  }
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _emailCtrl,
                decoration: InputDecoration(hintText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (text) {
                  if (text.isEmpty || !text.contains('@')) {
                    return 'E-mail inválido!!!';
                  }
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              TextFormField(
                controller: _passCtrl,
                decoration: InputDecoration(hintText: 'Senha'),
                obscureText: true,
                validator: (text) {
                  if (text.isEmpty || text.length < 6) {
                    return 'Senha inválida!!!';
                  }
                },
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 44.0,
                child: RaisedButton(
                  child: Text(
                    'Criar Conta',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Map<String, dynamic> userData = {
                        'name': _nameCtrl.text,
                        'email': _emailCtrl.text,
                        'address': _addressCtrl.text
                      };

                      model.singUp(
                        onFail: _onFail,
                        onSuccess: _onSucess,
                        pass: _passCtrl.text,
                        userData: userData,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _onSucess() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Usuario criado com sucesso'
        ),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 3),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }
  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Falha ao criar usuario'
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 3),
      )
    );
  }
}
