import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class MyClassPageBloc {
  Future<List> getMyClass() async {
    List myCourseClasses = [];
    try {
      String graphQLDocument = ''' query MyQuery(\$id: String) {
      myCourseClasses(id: \$id)
    }''';
      final awsUser = await Amplify.Auth.getCurrentUser();
      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
              document: graphQLDocument, variables: {"id": awsUser.username}));

      var response = await operation.response;
      Map<String, dynamic> result = jsonDecode(response.data);

      myCourseClasses =
          jsonDecode(result['myCourseClasses'])['ongoing_classes'];
      return myCourseClasses;
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return myCourseClasses;
  }
}
