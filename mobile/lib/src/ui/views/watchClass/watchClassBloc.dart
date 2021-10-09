import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class WatchClassBloc {
  Future<List> getWatchClass(int id) async {
    List courseSteps = [];
    List courseClasses = [];
    List responseWatch = [];
    try {
      String graphQLDocument =
          ''' query MyQuery(\$id: Int, \$user_id: String, \$course_id: Int) {
      getCourseSteps(id: \$id)
      getCourseClasses(user_id: \$user_id,course_id: \$course_id)
    }''';

      final awsUser = await Amplify.Auth.getCurrentUser();

      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
              document: graphQLDocument,
              variables: {
            "id": id,
            "user_id": awsUser.username,
            'course_id': id
          }));

      var response = await operation.response;
      Map<String, dynamic> result = jsonDecode(response.data);

      courseSteps = jsonDecode(result['getCourseSteps']);
      courseClasses = jsonDecode(result['getCourseClasses']);

      responseWatch.addAll([courseSteps, courseClasses]);
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return responseWatch;
  }

  Future<void> enrollCourseClass(int id) async {
    try {
      String graphQLDocument =
          ''' query MyQuery(\$id: Int, \$user_id: String, \$created_at: String, \$updated_at: String) {
      enrollCourseClass(course_class_id: \$id, user_id: \$user_id, created_at: \$created_at, updated_at: \$updated_at)
    }''';

      final awsUser = await Amplify.Auth.getCurrentUser();

      var operation = Amplify.API.query(
          request:
              GraphQLRequest<String>(document: graphQLDocument, variables: {
        "id": id,
        "user_id": awsUser.username,
        "created_at": '2021-01-01 00:00:00',
        "updated_at": '2021-01-01 00:00:00'
      }));

      await operation.response;
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
  }
}
