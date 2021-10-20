import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class CategoriesBloc {
  Future<List> getMainCategories() async {
    List mainCategories = [];
    try {
      String graphQLDocument =
          ''' query MyQuery {
      getMainCourseCategories
    }''';

      var operation = Amplify.API
          .query(request: GraphQLRequest<String>(document: graphQLDocument));

      var response = await operation.response;
      Map<String, dynamic> result = jsonDecode(response.data);

      mainCategories = jsonDecode(result['getMainCourseCategories']);
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return mainCategories;
  }
}
