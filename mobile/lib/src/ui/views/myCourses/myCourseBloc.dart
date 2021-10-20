import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class MyHomePageBloc {
  Future<List> getMyCourses() async {
    List myCourses = [];
    try {
      String graphQLDocument = ''' query MyQuery(\$id: String) {
      myCourses(id: \$id)
    }''';
      final awsUser = await Amplify.Auth.getCurrentUser();

      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
              document: graphQLDocument, variables: {"id": awsUser.username}));

      var response = await operation.response;

      Map<String, dynamic> result = jsonDecode(response.data);

      myCourses = jsonDecode(result['myCourses']);
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return myCourses;
  }
}
