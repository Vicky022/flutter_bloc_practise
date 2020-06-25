import 'package:equatable/equatable.dart';
import 'package:flutterblocpractise/model/covid.dart';

abstract class CovidState extends Equatable {
  const CovidState();
}

class CovidInitial extends CovidState {
  const CovidInitial();
  @override
  List<Object> get props => [];
}

class CovidLoading extends CovidState {
  const CovidLoading();
  @override
  List<Object> get props => [];
}

class CovidLoaded extends CovidState {
  final Covid covid;
  const CovidLoaded(this.covid);
  @override
  List<Object> get props => [covid];
}

class CovidError extends CovidState {
  final String message;
  const CovidError(this.message);
  @override
  List<Object> get props => [message];
}
