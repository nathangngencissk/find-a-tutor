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
                  child: Text('Não possui conta? Cadastre-se.')),
            )
          ],
        ),
        // child: Stack(
        //   children: <Widget>[
        //     Positioned(
        //       top: 0,
        //       child: Image.asset(
        //         "assets/images/imagelogin2.jpg",
        //       ),
        //     ),
        // Positioned(
        //   top: 190,
        //   child: Container(
        //     padding: EdgeInsets.all(32),
        //     width: MediaQuery.of(context).size.width,
        //     height: MediaQuery.of(context).size.height,
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(62),
        //             topRight: Radius.circular(62))),
        //   ),
        // ),
        // Positioned(
        //     top: 5,
        //     left: 5,
        //     child: Container(
        //       padding: EdgeInsets.all(32),
        //       width: MediaQuery.of(context).size.width,
        //       height: MediaQuery.of(context).size.height,
        //       child: Stack(children: [
        //         _loginForm(),
        //         Container(
        //           height: 800,
        //           alignment: Alignment.bottomCenter,
        //           child: FlatButton(
        //               onPressed: widget.shouldShowSignUp,
        //               child: Text('Não possui conta? Cadastre-se.')),
        //         )
        //       ]),
        //     )),
        // ],
        // ),
      ),
    );
  }
  // 3
  // body: SafeArea(
  //     minimum: EdgeInsets.symmetric(horizontal: 40),
  //     // 4
  //     child: Stack(children: [
  //       // Login Form
  //       _loginForm(),

  //       // 6
  //       // Sign Up Button
  //       Container(
  //         alignment: Alignment.bottomCenter,
  //         child: FlatButton(
  //             onPressed: widget.shouldShowSignUp,
  //             child: Text('Don\'t have an account? Sign up.')),
  //       )
  //     ])),
  // 5

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
        // Column(children: <Widget>[
        //   Container(
        //     height: 45,
        //     width: 60,
        //     alignment: Alignment.centerLeft,
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomRight,
        //         stops: [0.3, 1],
        //         colors: [Colors.blue[700], Colors.indigo[800]],
        //       ),
        //       borderRadius: BorderRadius.all(Radius.circular(5)),
        //     ),
        //     child: SizedBox.expand(
        //       child: FlatButton(
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: <Widget>[
        //             Text(
        //               '',
        //               style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.white,
        //                   fontSize: 17),
        //             ),
        //             Container(
        //               child: SizedBox(
        //                 child: Image.asset("assets/images/fbicon3.png"),
        //                 height: 28,
        //                 width: 28,
        //               ),
        //             ),
        //           ],
        //         ),
        //         onPressed: _login,
        //       ),
        //     ),
        //   ),
        //   Container(
        //     height: 45,
        //     width: 60,
        //     alignment: Alignment.centerLeft,
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.topLeft,
        //         end: Alignment.bottomRight,
        //         stops: [0.3, 1],
        //         colors: [Colors.blue[700], Colors.indigo[800]],
        //       ),
        //       borderRadius: BorderRadius.all(Radius.circular(5)),
        //     ),
        //     child: SizedBox.expand(
        //       child: FlatButton(
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: <Widget>[
        //             Text(
        //               '',
        //               style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   color: Colors.white,
        //                   fontSize: 17),
        //             ),
        //             Container(
        //               child: SizedBox(
        //                 child: Image.asset("assets/images/fbicon3.png"),
        //                 height: 28,
        //                 width: 28,
        //               ),
        //             ),
        //           ],
        //         ),
        //         onPressed: _login,
        //       ),
        //     ),
        //   ),
        // ])
        // Container(
        //   height: 45,
        //   width: 150,
        //   child: FlatButton(
        //       onPressed: _login,
        //       child: Text('Login com facebook'),
        //       color: Theme.of(context).accentColor),
        // ),

        // FlatButton(
        //     onPressed: _login,
        //     child: Text('Login com Facebook'),
        //     color: Theme.of(context).accentColor)
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
