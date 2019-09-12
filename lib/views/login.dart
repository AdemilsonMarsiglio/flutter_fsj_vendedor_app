import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sao_joao_app/bloc/login.bloc.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {

  final _focusNodePassword = FocusNode();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _controllerName = TextEditingController();
  final _controllerPass = TextEditingController();



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            color: Theme.of(context).accentColor,
            width: double.infinity,
            height: height / 2,
          ),
        ),
        ListView(
            padding: EdgeInsets.only(top: height/5),
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/images/logo_sj.png')
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: Container(
                  width: double.infinity,
                  height: 260,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        offset: Offset(0, 3),
                        blurRadius: 10
                      )
                    ]
                  ),
                  padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
                  child: Column(
                    children: <Widget>[
                      Text("Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.7)),),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          controller: _controllerName,
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (text) {
                            FocusScope.of(context).requestFocus(_focusNodePassword);
                          },
                          decoration: InputDecoration(
                            icon: Icon(Icons.person),
                            labelText: 'Informe seu usuário'
                          ),
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 20),
                        child: TextFormField(
                          controller: _controllerPass,
                          focusNode: _focusNodePassword,
                          textInputAction: TextInputAction.go,
                          obscureText: true,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            labelText: 'Informe sua senha'
                          ),
                          onFieldSubmitted: (t) => _login(),
                        ),
                      ),
                      Material(
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          hoverColor: Colors.red,
                          highlightColor: Colors.green,
                          focusColor: Colors.amber,
                          onTap: _login,
                          child: Container(
                            child: Text("Entrar", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16),),
                            width: 100,
                            height: 40,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
      ]
      ),
    );
  }


  _login() {

    String user = _controllerName.text;
    String pass = _controllerPass.text;

    if (user == null || user.isEmpty) {
      return _showSnackWarning("Informe seu usuário para continuar.");
    }

    if (pass == null || pass.isEmpty) {
      return _showSnackWarning("Informe a senha para continuar.");
    }

    final LoginController bloc = BlocProvider.getBloc<LoginController>();
    bloc.login(user, pass);

    return _showSnackWarning("Faz a ação de login com BLoC");
  }

  _showSnackWarning(String text) {
    final snack = SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      backgroundColor: Colors.amber[700],
      duration: Duration(seconds: 2),
    );

    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(snack);
  }
}
