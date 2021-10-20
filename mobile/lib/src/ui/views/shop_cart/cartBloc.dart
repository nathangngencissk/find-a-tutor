import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class CartBloc {
  Future<String> createPayment(List ids, value) async {
    String link = '';

    try {
      String graphQLDocument =
          ''' query MyQuery(\$courses: [Int], \$value: String, \$user_id: String) {
      createPayment(courses: \$courses, value: \$value, user_id: \$user_id)
    }''';

      final awsUser = await Amplify.Auth.getCurrentUser();

      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
              document: graphQLDocument,
              variables: {
            "courses": ids,
            "value": value,
            "user_id": awsUser.username
          }));

      var response = await operation.response;
      Map<String, dynamic> result = jsonDecode(response.data);

      link = result['createPayment'];
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return link;
  }
}
