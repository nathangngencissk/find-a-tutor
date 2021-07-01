import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.white,
        title: const Text(
          'Meu perfil',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            letterSpacing: 0.27,
            color: AppTheme.darkerText,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            child: SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                alignment: Alignment.center,
                fit: StackFit.expand,
                overflow: Overflow.visible,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/szostak.jpg"),
                  ),
                  Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(color: Colors.white),
                        ),
                        color: Color(0xFFF5F6F9),
                        onPressed: () {},
                        child: Image.asset(
                          "assets/images/iconCam.png",
                          height: 25,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Nome de usuário',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      letterSpacing: 0.27,
                      color: AppTheme.darkerText,
                    ),
                  ),
                ),
                Container(
                  width: 350,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Nome'),
                  ),
                ),
                Container(
                  width: 350,
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Sobrenome'),
                  ),
                ),
                Container(
                  height: 15,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: ElevatedButton(
                    child: Text(
                      'Salvar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Mudar senha',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      letterSpacing: 0.27,
                      color: AppTheme.darkerText,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock), labelText: 'Senha atual'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock), labelText: 'Nova senha'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 20, left: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Confirme sua senha'),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: ElevatedButton(
                    child: Text(
                      'Salvar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
