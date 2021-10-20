import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class CourseInfoBloc {
  Future<Map> getCourse(int id) async {
    Map course = {};

    try {
      String graphQLDocument = ''' query MyQuery(\$id: Int) {
      getCourse(id: \$id)
    }''';

      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
              document: graphQLDocument, variables: {"id": id}));

      var response = await operation.response;
      Map<String, dynamic> result = jsonDecode(response.data);

      course = jsonDecode(result['getCourse']);
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return course;
  }
}
