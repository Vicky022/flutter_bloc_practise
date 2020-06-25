import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocpractise/pages/covid_search_page.dart';

import 'bloc/covid_bloc.dart';
import 'data/covid_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid App',
      home: BlocProvider(
        builder: (context) => CovidBloc(FakeCovidRepository()),
        child: CovidSearchPage(),
      ),
    );
  }
}
