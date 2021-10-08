import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class SearchResultsBloc {
  Future<List> getSearchResults(String keywords) async {
    List searchResults = [];

    try {
      String graphQLDocument =
          ''' query MyQuery(\$keywords: [String]) {
      searchCourse(keywords: \$keywords)
    }''';

      var operation = Amplify.API.query(
          request:
              GraphQLRequest<String>(document: graphQLDocument, variables: {
        "keywords": [keywords]
      }));

      var response = await operation.response;
      Map<String, dynamic> result = jsonDecode(response.data);

      searchResults = jsonDecode(result['searchCourse']);
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return searchResults;
  }
}
