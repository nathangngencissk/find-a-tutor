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
        backgroundColor: Colors.white,
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
                    backgroundImage: AssetImage("assets/images/userImage.png"),
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
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ExpansionTile(
                title: Text('Nome de usuário'),
                children: <Widget>[
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
                  )
                ],
              ),
              ExpansionTile(
                title: Text('Foto de perfil'),
                children: <Widget>[
                  Container(
                    child: SizedBox(
                      height: 95,
                      width: 90,
                      child: Stack(
                        alignment: Alignment.center,
                        fit: StackFit.expand,
                        overflow: Overflow.visible,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/images/userImage.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      child: Text(
                        'Mudar Foto',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: Text('Mudar senha'),
                children: <Widget>[
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
              )
            ],
          )
        ],
      ),
    );
  }
}
