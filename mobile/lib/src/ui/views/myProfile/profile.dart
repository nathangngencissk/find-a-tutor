import 'dart:convert';
import 'dart:io';
import 'package:find_a_tutor/src/services/profile.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';
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

  Widget _previewImages() {
    return Consumer<ProfileService>(
      builder: (context, atts, child) => CircleAvatar(
        backgroundImage: NetworkImage(atts.picture),
      ),
    );
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
                            'Mudar nome',
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
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: ElevatedButton(
                            child: Text(
                              'Salvar',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              final name = _usernameController.text.trim();
                              var profile = context.read<ProfileService>();
                              profile.updateUserInfo('name', name);
                              _usernameController.clear();
                            },
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
                            controller: _oldPasswordController,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Senha atual'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                labelText: 'Nova senha'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, left: 10),
                          child: TextField(
                            controller: _confirmPasswordController,
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
                            onPressed: () async {
                              final oldPassword =
                                  _oldPasswordController.text.trim();
                              final password = _passwordController.text.trim();
                              final confirmPassword =
                                  _confirmPasswordController.text.trim();

                              if (password != confirmPassword) {
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

  void _updateUserPicture(String picture) async {
    try {
      var res = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: 'picture',
        value: picture,
      );
      if (res.nextStep.updateAttributeStep == 'CONFIRM_ATTRIBUTE_WITH_CODE') {
        var destination = res.nextStep.codeDeliveryDetails?.destination;
        print('Confirmation code sent to $destination');
      } else {
        print('Update completed');
      }
    } on AmplifyException catch (e) {
      print(e.message);
    }
  }
}
