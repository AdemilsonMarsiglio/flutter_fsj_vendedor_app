import 'package:bloc_pattern/bloc_pattern.dart';

class LoginController extends BlocBase {
  
  bool isLogged = true;

  login(String usuario, String senha) {
    isLogged = true;
    notifyListeners();
  }

  logout() {
    isLogged = false;
    notifyListeners();
  }
}