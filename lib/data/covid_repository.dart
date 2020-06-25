import 'dart:math';

import 'package:flutterblocpractise/model/covid.dart';

abstract class CovidRepository {
  Future<Covid> fetchTotalCases(String cityName);
  Future<Covid> fetchDetailedCases(String cityName);
}

class FakeCovidRepository implements CovidRepository {
  double cachedTotalCases;

  @override
  Future<Covid> fetchTotalCases(String cityName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        if (random.nextBool()) {
          throw NetworkError();
        }

        cachedTotalCases = 1000 + random.nextInt(1000) + random.nextDouble();

        return Covid(
          cityName: cityName,
          totalCases: cachedTotalCases,
        );
      },
    );
  }

  @override
  Future<Covid> fetchDetailedCases(String cityName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return Covid(
          cityName: cityName,
          totalCases: cachedTotalCases,
          totalDeath: cachedTotalCases * -100,
        );
      },
    );
  }
}

class NetworkError extends Error {}
