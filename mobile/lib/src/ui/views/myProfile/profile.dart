import 'dart:io';
import 'package:find_a_tutor/src/services/profile.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:find_a_tutor/src/ui/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker _picker = ImagePicker();
  final _usernameController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  var _oldPasswordVisible = false;
  var _passwordVisible = false;
  var _confirmPasswordVisible = false;

  Widget _previewImages() {
    return Consumer<ProfileService>(
      builder: (context, atts, child) => CircleAvatar(
        backgroundImage: NetworkImage(atts.picture),
      ),
    );
  }

  @override
  void initState() {
    _usernameController.text =
        Provider.of<ProfileService>(context, listen: false).userName;
    super.initState();
  }

  Widget _handlePreview() {
    return _previewImages();
  }

  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppTheme.white,
            title: Text(
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
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
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
                          GestureDetector(
                              onTap: () async {
                                final XFile image = await _picker.pickImage(
                                    source: ImageSource.gallery);

                                if (image == null) {
                                  print('No image selected');
                                  return;
                                }

                                var uuid = Uuid();

                                final key = uuid.v4() + '.png';

                                final options = S3UploadFileOptions(
                                  accessLevel: StorageAccessLevel.guest,
                                  contentType: 'image/png',
                                  metadata: <String, String>{
                                    'project': 'FindATutorAvatar',
                                  },
                                );

                                final file = File(image.path);
                                try {
                                  final UploadFileResult result =
                                      await Amplify.Storage.uploadFile(
                                          local: file,
                                          key: key,
                                          options: options);
                                  print(
                                      'Successfully uploaded image: ${result.key}');
                                  var profile = context.read<ProfileService>();
                                  profile.updateUserInfo('picture', result.key);
                                } on StorageException catch (e) {
                                  print('Error uploading image: $e');
                                }
                              },
                              child: _handlePreview()),
                          Positioned(
                            right: -16,
                            bottom: 0,
                            child: SizedBox(
                              height: 0,
                              width: 0,
                              child: GestureDetector(
                                  onTap: () async {
                                    final XFile photo = await _picker.pickImage(
                                        source: ImageSource.camera);
                                    var profile =
                                        context.read<ProfileService>();
                                    if (photo == null) {
                                      print('No image selected');
                                      return;
                                    }

                                    var uuid = Uuid();

                                    final key = uuid.v4() + '.png';

                                    final options = S3UploadFileOptions(
                                      accessLevel: StorageAccessLevel.guest,
                                      contentType: 'image/png',
                                      metadata: <String, String>{
                                        'project': 'FindATutorAvatar',
                                      },
                                    );

                                    final file = File(photo.path);
                                    try {
                                      final UploadFileResult result =
                                          await Amplify.Storage.uploadFile(
                                              local: file,
                                              key: key,
                                              options: options);
                                      print(
                                          'Successfully uploaded image: ${result.key}');
                                      var profile =
                                          context.read<ProfileService>();
                                      profile.updateUserInfo(
                                          'picture', result.key);
                                    } on StorageException catch (e) {
                                      print('Error uploading image: $e');
                                    }
                                  },
                                  child: new FlatButton(
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
                                  )),
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
                            'Alterar nome',
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
                            controller: _usernameController,
                            decoration: InputDecoration(labelText: 'Nome'),
                          ),
                        ),
                        Container(
                          height: 20,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: EdgeInsets.only(left: 20),
                          child: Text(
                            'Alterar senha',
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
                            controller: _oldPasswordController,
                            decoration: InputDecoration(
                              labelText: 'Senha atual',
                              hintText: 'Senha atual',
                              icon: Icon(Icons.lock_open),
                              // Here is key idea
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _oldPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _oldPasswordVisible = !_oldPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: _oldPasswordVisible,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              labelText: 'Nova senha',
                              hintText: 'Nova senha',
                              icon: Icon(Icons.lock_open),
                              // Here is key idea
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: _passwordVisible,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextField(
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              labelText: 'Confirme sua senha',
                              hintText: 'Confirme sua senha',
                              icon: Icon(Icons.lock_open),
                              // Here is key idea
                              suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  _confirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                onPressed: () {
                                  // Update the state i.e. toogle the state of passwordVisible variable
                                  setState(() {
                                    _confirmPasswordVisible =
                                        !_confirmPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: _confirmPasswordVisible,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 25, bottom: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                textStyle: const TextStyle(fontSize: 25)),
                            child: Text(
                              'Salvar',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              final name = _usernameController.text.trim();

                              if (name.length > 0) {
                                var profile = context.read<ProfileService>();
                                profile.updateUserInfo('name', name);
                                _usernameController.clear();
                              }

                              final oldPassword =
                                  _oldPasswordController.text.trim();
                              final password = _passwordController.text.trim();
                              final confirmPassword =
                                  _confirmPasswordController.text.trim();

                              if (password != confirmPassword ||
                                  oldPassword.length == 0) {
                                return;
                              }
                              _oldPasswordController.clear();
                              _passwordController.clear();
                              _confirmPasswordController.clear();
                              try {
                                await Amplify.Auth.updatePassword(
                                    newPassword: password,
                                    oldPassword: oldPassword);
                              } on AmplifyException catch (e) {
                                print(e);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
