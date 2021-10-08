import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class DetailClassBloc {
  final StreamController<String> _streamController = StreamController<String>();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  Future<List> getDetailClass(int id) async {
    List courseSteps = [];
    List courseClasses = [];
    List responseWatch = [];

    try {
      String graphQLDocument =
          ''' query MyQuery(\$id: Int, \$user_id: String, \$course_id: Int) {
      getCourseSteps(id: \$id)
      getCourseClasses(user_id: \$user_id, course_id: \$course_id)
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
      print(responseWatch);
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return responseWatch;
  }
}
