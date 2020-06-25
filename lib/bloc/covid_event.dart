import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CovidEvent extends Equatable {
  const CovidEvent();
}

class GetTotalCases extends CovidEvent {
  final String cityName;

  const GetTotalCases(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class GetDetailedCases extends CovidEvent {
  final String cityName;

  const GetDetailedCases(this.cityName);

  @override
  List<Object> get props => [cityName];
}
