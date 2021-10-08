import 'dart:async';
import 'dart:convert';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_api/amplify_api.dart';

class CarouselBloc {
  Future<List> getCarousel() async {
    List carouselImage = [];

    try {
      String graphQLDocument = ''' query MyQuery {
      getStudyingNow
    }''';

      var operation = Amplify.API
          .query(request: GraphQLRequest<String>(document: graphQLDocument));

      var response = await operation.response;
      Map<String, dynamic> result = jsonDecode(response.data);

      carouselImage = jsonDecode(result['getStudyingNow']);

      print(carouselImage);
    } on ApiException catch (e) {
      print('Query failed: $e');
    }
    return carouselImage;
  }
}
