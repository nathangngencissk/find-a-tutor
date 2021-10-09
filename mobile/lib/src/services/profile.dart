import 'dart:convert';

import 'package:amplify_flutter/amplify.dart';
import 'package:find_a_tutor/src/utils/imageFromS3.dart';
import 'package:flutter/material.dart';

class ProfileService with ChangeNotifier {
  String provider = '';
  String userName = '';
  String picture = '';

  ProfileService() {
    getUserInfo();
  }

  void getUserInfo() async {
    ImageFromS3 imageFromS3 = ImageFromS3();
    final userInfo = await Amplify.Auth.fetchUserAttributes();
    userInfo.forEach((element) {
      if (element.userAttributeKey == 'identities') {
        List<dynamic> providerJson = jsonDecode(element.value);
        provider = providerJson[0]['providerName'];
      }
    });
    userInfo.forEach((element) async {
      if (element.userAttributeKey == 'picture') {
        if (provider == 'Google') {
          picture = element.value;
        } else if (provider == 'Facebook') {
          picture = await imageFromS3
              .getDownloadUrlReturn('default-profile-picture.png');
        } else {
          picture = await imageFromS3.getDownloadUrlReturn(element.value);
        }
      } else if (element.userAttributeKey == 'name') {
        userName = element.value;
      }
    });
    notifyListeners();
  }

  void updateUserInfo(String field, String value) async {
    try {
      var res = await Amplify.Auth.updateUserAttribute(
        userAttributeKey: field,
        value: value,
      );
      if (res.nextStep.updateAttributeStep == 'CONFIRM_ATTRIBUTE_WITH_CODE') {
        var destination = res.nextStep.codeDeliveryDetails?.destination;
        print('Confirmation code sent to $destination');
      } else {
        print('Update completed');
        if (field == 'name') {
          userName = value;
        } else {
          ImageFromS3 imageFromS3 = ImageFromS3();
          picture = await imageFromS3.getDownloadUrlReturn(value);
        }
        notifyListeners();
      }
    } on AmplifyException catch (e) {
      print(e.message);
    }
  }
}
