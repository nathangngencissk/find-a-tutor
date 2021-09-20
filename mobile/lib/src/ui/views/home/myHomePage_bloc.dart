import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class MyHomePageBloc {
  final StreamController<String> _streamController = StreamController<String>();

  Sink get input => _streamController.sink;
  Stream get output => _streamController.stream;

  Future<List> getPopularCourse() async {
    List popularCourses = [];
    try {
      String graphQLDocument = ''' query MyQuery {
      getPopularCourses
    }''';

      var operation = Amplify.API
          .query(request: GraphQLRequest<String>(document: graphQLDocument));

      var response = await operation.response;
      Map<String, dynamic> result = jsonDecode(response.data);

      popularCourses = jsonDecode(result['getPopularCourses']);
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return popularCourses;
  }
}
