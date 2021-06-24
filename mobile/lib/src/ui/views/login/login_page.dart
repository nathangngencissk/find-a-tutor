import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:find_a_tutor/src/utils/auth_credentials.dart';

class LoginPage extends StatefulWidget {
  final ValueChanged<LoginCredentials> didProvideCredentials;
  final VoidCallback shouldShowSignUp;

  LoginPage({Key key, this.didProvideCredentials, this.shouldShowSignUp})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // 1
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // 2
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: 60,
          left: 40,
          right: 40,
        ),
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 230,
              height: 230,
              child: Image.asset(
                "assets/images/main_logo.png",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _loginForm(),
            Container(
              height: 100,
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: widget.shouldShowSignUp,
                child: Text('Não possui conta? Cadastre-se.'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
              icon: Icon(Icons.mail), labelText: 'Nome de usuário'),
        ),
        // Password TextField
        TextField(
          controller: _passwordController,
          decoration:
              InputDecoration(icon: Icon(Icons.lock_open), labelText: 'Senha'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),
        Container(
          height: 20,
        ),
        Container(
          height: 45,
          width: 250,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.3, 1],
              colors: [Colors.blue[300], Colors.blue[800]],
            ),
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: SizedBox.expand(
            child: FlatButton(
              onPressed: _login,
              child: Text(
                'Login',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17),
              ),
            ),
          ),
        ),
        Container(
          height: 6,
        ),
        new ButtonTheme(
            child: new ButtonBar(
          alignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
              Buttons.Facebook,
              mini: true,
              onPressed: () {},
            ),
            SignInButton(
              Buttons.Email,
              mini: true,
              onPressed: () {},
            ),
          ],
        ))
      ],
    );
  }

  // 7
  void _login() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('password: $password');

    final credentials =
        LoginCredentials(username: username, password: password);
    widget.didProvideCredentials(credentials);
  }
}
