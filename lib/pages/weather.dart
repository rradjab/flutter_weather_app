import 'package:flutter/material.dart';

import '../api/api.dart';
import '../models/weather_model.dart';
import '../widgets/weather_view.dart';

class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Weather> {
  late Future<CityWeather> _cityWeather;

  String selectedCity = 'Baku';
  @override
  void initState() {
    super.initState();
    _cityWeather = getWeather(selectedCity);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(selectedCity),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(14.0),
          child: Container(
            color: Colors.lightBlue,
            child: Autocomplete(
              optionsBuilder: (TextEditingValue textEditingValue) {
                return getCountries(textEditingValue.text);
              },
              onSelected: (String selection) {
                setState(() {
                  _cityWeather = getWeather(selection);
                });
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _cityWeather,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            CityWeather cw = snapshot.data!;
            return WeatherView(
              cityWeather: cw,
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Səhv: ${snapshot.error.toString()}"),
            );
          }
          return const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
