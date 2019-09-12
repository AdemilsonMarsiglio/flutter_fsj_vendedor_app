import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:sao_joao_app/bloc/login.bloc.dart';
import 'package:sao_joao_app/views/home.dart';
import 'package:sao_joao_app/views/login.dart';


void main() => runApp(
  BlocProvider(
    child: MyApp(),
    blocs: [
      Bloc((i) => LoginController()),
    ],
  ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      home: Consumer<LoginController>(
        builder: (BuildContext context, LoginController bloc) {
          print("Altera status logado BLoC: ${bloc.isLogged}");
          if (bloc.isLogged) {
            return HomeWidget();
          }
          return LoginWidget();
        },
      ),
    );
  }
}