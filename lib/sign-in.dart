import 'package:booking/main.dart';
import 'package:booking/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController _loginController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  String _login;
  String _password;
  String _email;
  bool _isLoginShowed = true;

  AuthService _authService = AuthService();
  // FirebaseAuth _authService = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 150),
        child: Container(
          child: Align(
            child: Text(
              'This is BOOKING',
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[400]),
            ),
          ),
        ),
      );
    }

    Widget _input(
        Icon icon, String hint, TextEditingController controller, bool flag) {
      return Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: controller,
            obscureText: flag,
            style: TextStyle(fontSize: 24, color: Colors.teal[400]),
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.teal[400]),
                hintText: hint,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal[400], width: 3)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal[400], width: 1)),
                prefixIcon: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: IconTheme(
                      data: IconThemeData(color: Colors.teal[400]),
                      child: icon,
                    ))),
          ));
    }

    Widget _button(String text, void func()) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.teal,
        ),
        child: Text(text,
            style: TextStyle(
                color: Colors.blueGrey[900],
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        onPressed: () {
          func();
        },
      );
    }

    Widget _form(String label, void func()) {
      return Container(
        child: Column(
          children: <Widget>[
            (!_isLoginShowed
                ? Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: _input(
                        Icon(Icons.email), 'EMAIL', _emailController, false),
                  )
                : Container(
                    child: null,
                  )),
            Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child:
                  _input(Icon(Icons.login), 'LOGIN', _loginController, false),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: _input(
                  Icon(Icons.lock), 'PASSWORD', _passwordController, true),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 30),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: _button(label, func),
              ),
            )
          ],
        ),
      );
    }

    void _signInButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      dynamic user = await _authService.signIn(_email.trim(), _password.trim());
      if (user == null)
        Fluttertoast.showToast(
            msg: "Can't SignIn you! Please check your email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _navigator() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MapPage()));
    }

    void _registerButtonAction() async {
      _email = _emailController.text;
      _password = _passwordController.text;

      dynamic user =
          await _authService.register(_email.trim(), _password.trim());
      if (user == null)
        Fluttertoast.showToast(
            msg: "Can't Register you! Please check your email/password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _logo(),
              (_isLoginShowed
                  ? Column(
                      children: <Widget>[
                        _form('Войти', _navigator),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Text("Еще нет аккаунта? Создайте",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.teal[400])),
                            onTap: () {
                              setState(() {
                                _isLoginShowed = false;
                              });
                            },
                          ),
                        )
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        _form('Зарегистрироваться', _navigator),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                            child: Text("Уже есть аккаунт? Войдите",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.teal[400])),
                            onTap: () {
                              setState(() {
                                _isLoginShowed = true;
                              });
                            },
                          ),
                        )
                      ],
                    ))
            ],
          ),
        ));
  }
}
