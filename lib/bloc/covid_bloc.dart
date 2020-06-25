import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterblocpractise/data/covid_repository.dart';
import 'bloc.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  final CovidRepository repository;

  CovidBloc(this.repository);

  @override
  CovidState get initialState => CovidInitial();

  @override
  Stream<CovidState> mapEventToState(
    CovidEvent event,
  ) async* {
    yield CovidLoading();

    if (event is GetTotalCases) {
      try {
        final covid = await repository.fetchTotalCases(event.cityName);
        yield CovidLoaded(covid);
      } on NetworkError {
        yield CovidError("Couldn't fetch result. Is the device online?");
      }
    } else if (event is GetDetailedCases) {
      try {
        final covid = await repository.fetchDetailedCases(event.cityName);
        yield CovidLoaded(covid);
      } on NetworkError {
        yield CovidError("Couldn't fetch result. Is the device online?");
      }
    }
  }
}
