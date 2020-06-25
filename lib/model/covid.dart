import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Covid extends Equatable {
  final String cityName;
  final double totalCases;
  final double totalDeath;

  Covid({
    @required this.cityName,
    @required this.totalCases,
    this.totalDeath,
  });

  @override
  List<Object> get props => [
        cityName,
        totalCases,
        totalDeath,
      ];
}
