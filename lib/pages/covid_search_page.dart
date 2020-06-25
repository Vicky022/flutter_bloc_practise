import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocpractise/bloc/bloc.dart';
import 'package:flutterblocpractise/model/covid.dart';

import 'covid_detail_page.dart';

class CovidSearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid cases Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocListener<CovidBloc, CovidState>(
          listener: (context, state) {
            if (state is CovidError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<CovidBloc, CovidState>(
            builder: (context, state) {
              if (state is CovidInitial) {
                return buildInitialInput();
              } else if (state is CovidLoading) {
                return buildLoading();
              } else if (state is CovidLoaded) {
                return buildColumnWithData(context, state.covid);
              } else if (state is CovidError) {
                return buildInitialInput();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
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
            fontSize: 70,
            fontWeight: FontWeight.w700,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            // Display the temperature with 1 decimal place
            "${covid.totalCases.toStringAsFixed(1)} ",
            style: TextStyle(fontSize: 60),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            // Display the temperature with 1 decimal place
            "Total Cases ",
            style: TextStyle(fontSize: 40),
            textAlign: TextAlign.center,
          ),
        ),
        RaisedButton(
          child: Text('See Details'),
          color: Colors.lightBlue[100],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: BlocProvider.of<CovidBloc>(context),
                  child: CovidDetailPage(
                    masterWeather: covid,
                  ),
                ),
              ),
            );
          },
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: "Enter a city",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    final covidBloc = BlocProvider.of<CovidBloc>(context);
    covidBloc.add(GetTotalCases(cityName));
  }
}
