import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocpractise/bloc/bloc.dart';
import 'package:flutterblocpractise/model/covid.dart';

class CovidDetailPage extends StatefulWidget {
  final Covid masterWeather;

  const CovidDetailPage({
    Key key,
    @required this.masterWeather,
  }) : super(key: key);

  @override
  _CovidDetailPageState createState() => _CovidDetailPageState();
}

class _CovidDetailPageState extends State<CovidDetailPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<CovidBloc>(context)
      ..add(GetDetailedCases(widget.masterWeather.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Total Death"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocBuilder<CovidBloc, CovidState>(
          // ignore: missing_return
          builder: (context, state) {
            if (state is CovidLoading) {
              return buildLoading();
            } else if (state is CovidLoaded) {
              return buildColumnWithData(context, state.covid);
            }
          },
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(BuildContext context, Covid covid) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          covid.cityName,
          style: TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "${covid.totalCases.toStringAsFixed(1)} ",
            style: TextStyle(fontSize: 60),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Total Cases ",
            style: TextStyle(fontSize: 40),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "${covid.totalDeath.toStringAsFixed(1)} ",
            style: TextStyle(fontSize: 60),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Total Cases ",
            style: TextStyle(fontSize: 40),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
