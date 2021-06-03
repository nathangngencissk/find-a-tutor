import 'package:flutter/material.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:find_a_tutor/src/utils/amplifyconfiguration.dart';
import 'package:find_a_tutor/src/utils/auth_service.dart';
import 'package:find_a_tutor/src/ui/shared/navigation_home_screen.dart';
// import 'package:find_a_tutor/src/ui/views/home/home_page.dart';
import 'package:find_a_tutor/src/ui/views/login/login_page.dart';
import 'package:find_a_tutor/src/ui/views/sign_up/sign_up_page.dart';
import 'package:find_a_tutor/src/ui/views/verification/verification_page.dart';

void main() => runApp(MyApp());

BuildContext testContext;

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Bottom Navigation Bar example project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: MyBottomNavigatonBar(),
      // home: NavigationHomeScreen(),
      // initialRoute: '/',
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/first': (context) => NavigationHomeScreen(),
      // },
    );
  }
}

class _MyAppState extends State<MyApp> {
  final _amplify = Amplify;
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    _authService.checkAuthStatus();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
      // 2
      home: StreamBuilder<AuthState>(
          // 2
          stream: _authService.authStateController.stream,
          builder: (context, snapshot) {
            // 3
            if (snapshot.hasData) {
              return Navigator(
                pages: [
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                    MaterialPage(
                        child: LoginPage(
                            didProvideCredentials:
                                _authService.loginWithCredentials,
                            shouldShowSignUp: _authService.showSignUp)),
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                    MaterialPage(
                        child: SignUpPage(
                            didProvideCredentials:
                                _authService.signUpWithCredentials,
                            shouldShowLogin: _authService.showLogin)),
                  if (snapshot.data.authFlowStatus ==
                      AuthFlowStatus.verification)
                    MaterialPage(
                        child: VerificationPage(
                            didProvideVerificationCode:
                                _authService.verifyCode)),
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                    MaterialPage(
                        child: NavigationHomeScreen(
                            shouldLogOut: _authService.logOut))
                ],
                onPopPage: (route, result) => route.didPop(result),
              );
            } else {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }

  void _configureAmplify() async {
    await _amplify.addPlugin(AmplifyAuthCognito());
    try {
      await Amplify.configure(amplifyconfig);
      print('Successfully configured Amplify 🎉');
    } catch (e) {
      print('Could not configure Amplify ☠️');
    }
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

// class MyBottomNavigatonBar extends StatefulWidget {
//   @override
//   _MyBottomNavigatonBarState createState() => _MyBottomNavigatonBarState();
// }

// class _MyBottomNavigatonBarState extends State<MyBottomNavigatonBar> {
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//               icon: new Icon(Icons.home), title: new Text('Home')),
//           BottomNavigationBarItem(
//               icon: new Icon(Icons.search), title: new Text('Pesquisar')),
//           BottomNavigationBarItem(
//               icon: new Icon(Icons.bookmark), title: new Text('Meus Cursos')),
//           BottomNavigationBarItem(
//               icon: new Icon(Icons.person), title: new Text('Perfil')),
//         ],
//       ),
//     );
//   }
// }
