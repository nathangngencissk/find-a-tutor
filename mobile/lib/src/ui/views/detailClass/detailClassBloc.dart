import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class DetailClassBloc {
  Future<List> getDetailClass(int id) async {
    List classPosts = [];
    List courseClass = [];
    List responseClass = [];

    try {
      String graphQLDocument = ''' query MyQuery(\$id: Int) {
      getCourseClassPosts(course_class_id: \$id)
      getCourseClass(id: \$id)
    }''';

      var operation = Amplify.API.query(
          request:
              GraphQLRequest<String>(document: graphQLDocument, variables: {
        "id": id,
      }));

      var response = await operation.response;
      Map<String, dynamic> result = jsonDecode(response.data);

      classPosts = jsonDecode(result['getCourseClassPosts']);
      courseClass = jsonDecode(result['getCourseClass']);

      responseClass.addAll([classPosts, courseClass[0]]);
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return responseClass;
  }
}
