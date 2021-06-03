import 'package:flutter/material.dart';
import 'package:find_a_tutor/src/utils/auth_credentials.dart';

class SignUpPage extends StatefulWidget {
  final ValueChanged<SignUpCredentials> didProvideCredentials;
  final VoidCallback shouldShowLogin;

  SignUpPage({Key key, this.didProvideCredentials, this.shouldShowLogin})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40),
          child: Stack(children: [
            // Sign Up Form
            _signUpForm(),

            // Login Button
            Container(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                  onPressed: widget.shouldShowLogin,
                  child: Text('Ja possui conta? Faça o login.')),
            )
          ])),
    );
  }

  Widget _signUpForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Username TextField
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(
              icon: Icon(Icons.person), labelText: 'Nome de usuário'),
        ),

        // Email TextField
        TextField(
          controller: _emailController,
          decoration:
              InputDecoration(icon: Icon(Icons.mail), labelText: 'E-mail'),
        ),

        // Password TextField
        TextField(
          controller: _passwordController,
          decoration:
              InputDecoration(icon: Icon(Icons.lock_open), labelText: 'Senha'),
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
        ),

        // Sign Up Button
        FlatButton(
            onPressed: _signUp,
            child: Text('Cadastre-se'),
            color: Theme.of(context).accentColor)
      ],
    );
  }

  void _signUp() {
    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    print('username: $username');
    print('email: $email');
    print('password: $password');

    final credentials =
        SignUpCredentials(username: username, email: email, password: password);
    widget.didProvideCredentials(credentials);
  }
}
